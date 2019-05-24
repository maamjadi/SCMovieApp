//
//  MovieObjectDTO.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//

import Foundation

struct MovieObjectDTO: Decodable {
    var vote_count: Int
    var id: Int
    var video: Bool
    var vote_average: Float
    var title: String
    var popularity: Float
    var poster_path: String
    var original_language: String
    var original_title: String
    var genres: [Genres]?
    var backdrop_path: String
    var adult: Bool
    var overview: String
    var release_date: String
}


struct Genres: Decodable {
    var id: Int
    var name: String
}

struct GeneralResponseDTO: Decodable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [MovieObjectDTO]
}
