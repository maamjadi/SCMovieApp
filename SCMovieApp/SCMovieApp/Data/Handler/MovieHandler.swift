//
//  MovieHandler.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//

import Foundation
import CoreData

enum HttpMethods: String {
    case get = "GET"
}

class MovieHandler: NSObject {

    static let shared = MovieHandler()

    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "api_key=43a7ea280d085bd0376e108680615c7f"
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500/"

    private static var mainContext: NSManagedObjectContext!

    override init() {
        let container = NSPersistentContainer.create(for: "SCMovieApp")
        container.viewContext.automaticallyMergesChangesFromParent = true
        MovieHandler.mainContext = container.viewContext
        super.init()
    }

    private func getRequest(for url: URL) -> URLRequest {
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = HttpMethods.get.rawValue.uppercased()
        return request as URLRequest
    }

    func getPopularMovies(completionHandler: @escaping (_ success:Bool, _ error: String?, _ data: [Movie]?) -> Void) {

        let date = Date().getFormattedString()
        if let movies = Movie.getItems(for: date, context: MovieHandler.mainContext), !movies.isEmpty {
            completionHandler(true, nil, movies)
        } else {
            let urlString = "\(baseURL)movie/popular?page=1&language=en-US&\(apiKey)"
            guard let url = URL(string: urlString) else {
                return
            }
            getGeneralMovies(with: getRequest(for: url), date: date, completionHandler: completionHandler)
        }
    }

    func getSearchedMovies(for searchText: String,
                           completionHandler: @escaping (_ success:Bool, _ error: String?, _ data: [Movie]?) -> Void) {
        let queryString = "query=" + searchText.replacingOccurrences(of: " ",
                                                                     with: "%20",
                                                                     options: .literal,
                                                                     range: nil)
        let urlString = "\(baseURL)search/movie?page=1&language=en-US&\(apiKey)&\(queryString)"
        guard let url = URL(string: urlString) else {
            return
        }
        getGeneralMovies(with: getRequest(for: url), completionHandler: completionHandler)
    }

    private func getGeneralMovies(with request: URLRequest,
                          date: String? = nil,
                          completionHandler: @escaping (_ success:Bool, _ error: String?, _ data: [Movie]?) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //start the asynchronous task on main thread
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(false, "Fail to get data from url:\(error)", nil)
                    return
                }

                guard let data = data else {
                    completionHandler(false, nil, nil)
                    return
                }

                do {
                    //decoding the json data
                    let decoder = JSONDecoder()
                    let movieGeneralObject = try decoder.decode(GeneralResponseDTO.self, from: data)
                    let movies = Movie.addOrUpdateMovies(from: movieGeneralObject, date: date, context: MovieHandler.mainContext)
                    MovieHandler.mainContext.cd_saveToPersistentStore()
                    completionHandler(true, nil, movies)
                } catch let jsonErr {
                    completionHandler(false, "Fail to decode:\(jsonErr)", nil)
                }
            }
            }.resume()
    }

    func getMovie(with id: Int, completionHandler: @escaping (_ success:Bool, _ error: String?, _ data: Movie?) -> Void) {
        if let movie = Movie.getItem(by: id, context: MovieHandler.mainContext) {
            completionHandler(true, nil, movie)
        } else {
            let urlString = "\(baseURL)movie/\(id)?language=en-US&\(apiKey)"
            guard let url = URL(string: urlString) else {
                return
            }

            URLSession.shared.dataTask(with: getRequest(for: url)) { (data, _, error) in
                //start the asynchronous task on main thread
                DispatchQueue.main.async {
                    if let error = error {
                        completionHandler(false, "Fail to get data from url:\(error)", nil)
                        return
                    }

                    guard let data = data else {
                        completionHandler(false, nil, nil)
                        return
                    }

                    do {
                        //decoding the json data
                        let decoder = JSONDecoder()
                        let movieObject = try decoder.decode(MovieObjectDTO.self, from: data)
                        let movies = Movie.addOrUpdateMovies(from: [movieObject], context: MovieHandler.mainContext)
                        MovieHandler.mainContext.cd_saveToPersistentStore()
                        completionHandler(true, nil, movies[0])
                    } catch let jsonErr {
                        completionHandler(false, "Fail to decode:\(jsonErr)", nil)
                    }
                }
                }.resume()
        }
    }

    func getImageURL(from urlString: String?) -> URL? {
        if let urlString = urlString,
            let url = URL(string: imageBaseURL + urlString) {
            return url
        }
        return nil
    }


}
