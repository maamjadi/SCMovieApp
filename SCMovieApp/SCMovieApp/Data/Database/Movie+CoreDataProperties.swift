//
//  Movie+CoreDataProperties.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var voteCount: Int64
    @NSManaged public var id: Int64
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Float
    @NSManaged public var title: String?
    @NSManaged public var popularity: Float
    @NSManaged public var posterPath: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var genres: [String]?
    @NSManaged public var backdropPath: String?
    @NSManaged public var adult: Bool
    @NSManaged public var overView: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var fetchDate: NSDate

}
