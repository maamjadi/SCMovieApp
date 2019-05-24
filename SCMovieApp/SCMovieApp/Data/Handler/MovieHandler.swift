//
//  MovieHandler.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//

import Foundation

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
}

class MovieHandler {

    let baseURL = "https://api.themoviedb.org/3/movie/"
    let apiKey = "api_key=43a7ea280d085bd0376e108680615c7f"

    func getPopularMovies(completionHandler: @escaping (_ success:Bool, _ error: String?, _ data: [Rate]?) -> Void) {
        let urlString = "\(baseURL)popular?page=1&language=en-US&\(apiKey)"
        guard let url = URL(string: urlString) else {
            return
        }
        var request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = HttpMethods.get.rawValue
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            <#code#>
        }
    }


}
