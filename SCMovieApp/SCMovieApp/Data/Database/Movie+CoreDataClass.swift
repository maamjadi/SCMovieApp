//
//  Movie+CoreDataClass.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {

    class func fetchRates(for id: Int, context: NSManagedObjectContext) -> NSFetchedResultsController<Movie>? {
        return Movie.cd_fetchAll(withPredicate: NSPredicate(format: "id == \(id)"),
                                sortedBy: [("date", .desc)],
                                delegate: nil,
                                faulting: false,
                                context: context)
    }

    class func getItem(by id: Int, context: NSManagedObjectContext) -> Movie? {
        let results: [Movie]? = Movie.cd_findAll(inContext: context,
                                               predicate: NSPredicate(format: "id == \(id)"))
        return results?.first
    }

    class func getItems(for date: String, context: NSManagedObjectContext) -> [Movie]? {
        let results: [Movie]? = Movie.cd_findAll(inContext: context,
                                               predicate: NSPredicate(format: "fetchDate == %@", date))
        return results
    }

    class func addOrUpdateRates(from content: GeneralResponseDTO, date: String? = nil, context: NSManagedObjectContext) -> [Movie] {
        return addOrUpdateRates(from: content.results, context: context)
    }

    class func addOrUpdateRates(from content: [MovieObjectDTO], date: String? = nil, context: NSManagedObjectContext) -> [Movie] {
        var movies = [Movie]()
        content.forEach { movieDTO in
            if let id = movieDTO.id, let movie = Movie.getItem(by: id,
                                       context: context) ?? Movie.cd_new(inContext: context) {
                movie.voteCount = Int64(movieDTO.vote_count ?? 0)
                movie.id = Int64(movieDTO.id ?? 0)
                movie.video = movieDTO.video ?? false
                movie.voteAverage = movieDTO.vote_average ?? 0
                movie.title = movieDTO.title
                movie.popularity = movieDTO.popularity ?? 0
                movie.posterPath = movieDTO.poster_path
                movie.originalLanguage = movieDTO.poster_path
                movie.originalTitle = movieDTO.original_title
                movie.genres = movieDTO.genres?.map({ $0.name })
                movie.backdropPath = movieDTO.backdrop_path
                movie.adult = movieDTO.adult ?? false
                movie.overView = movieDTO.overview
                movie.releaseDate = movieDTO.release_date
                movie.fetchDate = date

                movies.append(movie)
            }
        }
        return movies
    }

}
