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

    private let baseURL = "https://api.themoviedb.org/3/movie/"
    private let apiKey = "api_key=43a7ea280d085bd0376e108680615c7f"
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500/"

    private static var mainContext: NSManagedObjectContext!

    override init() {
        let container = NSPersistentContainer.create(for: "SCMovieApp")
        container.viewContext.automaticallyMergesChangesFromParent = true
        MovieHandler.mainContext = container.viewContext
        super.init()
    }

    func getPopularMovies(completionHandler: @escaping (_ success:Bool, _ error: String?, _ data: [Movie]?) -> Void) {

        let date = Date().getFormattedString()

        //checking if we have fetch the todaysRates before, to just return it
        if let movies = Movie.getItems(for: date, context: MovieHandler.mainContext), !movies.isEmpty {
            completionHandler(true, nil, movies)
        } else {
            let urlString = "\(baseURL)popular?page=1&language=en-US&\(apiKey)"
            guard let url = URL(string: urlString) else {
                return
            }
            let request = NSMutableURLRequest(url: url,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = HttpMethods.get.rawValue.uppercased()
            URLSession.shared.dataTask(with: request as URLRequest) { (data, _, error) in
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
                        let rates = Movie.addOrUpdateRates(from: movieGeneralObject, date: date, context: MovieHandler.mainContext)
                        MovieHandler.mainContext.cd_saveToPersistentStore()
                        completionHandler(true, nil, rates)
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
