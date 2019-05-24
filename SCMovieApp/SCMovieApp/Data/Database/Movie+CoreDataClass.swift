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

    class func fetchRates(for id: Int64, context: NSManagedObjectContext) -> NSFetchedResultsController<Movie>? {
        return Movie.cd_fetchAll(withPredicate: NSPredicate(format: "id == %@", id),
                                sortedBy: [("date", .desc)],
                                delegate: nil,
                                faulting: false,
                                context: context)
    }

    class func getItem(by id: Int64, context: NSManagedObjectContext) -> Movie? {
        let results: [Movie]? = Movie.cd_findAll(inContext: context,
                                               predicate: NSPredicate(format: "id == %@", id))
        return results?.first
    }

    class func getItems(for date: NSDate, context: NSManagedObjectContext) -> [Movie]? {
        let results: [Movie]? = Movie.cd_findAll(inContext: context,
                                               predicate: NSPredicate(format: "fetchDate == %@", date))
        return results
    }

    class func addOrUpdateRates(from content: GeneralResponseDTO, context: NSManagedObjectContext) -> [Movie] {
        return addOrUpdateRates(from: content.results, context: context)
    }

    class func addOrUpdateRates(from content: [MovieObjectDTO], context: NSManagedObjectContext) -> [Movie] {
        var movies = [Movie]()
        content.forEach { movieDTO in
            if let movie = Movie.getItem(by: Int64(movieDTO.id),
                                       context: context) ?? Movie.cd_new(inContext: context) {
                movie.voteCount = Int64(movieDTO.vote_count)
                movie.id = Int64(movieDTO.id)
                movie.video = movieDTO.video
                movie.voteAverage = movieDTO.vote_average
                movie.title = movieDTO.title
                movie.popularity = movieDTO.popularity
                movie.posterPath = movieDTO.poster_path
                movie.originalLanguage = movieDTO.poster_path
                movie.originalTitle = movieDTO.original_title
                movie.genres = movieDTO.genres?.map({ $0.name })
                movie.backdropPath = movieDTO.backdrop_path
                movie.adult = movieDTO.adult
                movie.overView = movieDTO.overview
                movie.releaseDate = movieDTO.release_date

                movies.append(movie)
            }
        }
        return movies
    }

}
