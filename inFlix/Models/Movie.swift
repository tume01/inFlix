//
//  Movie.swift
//  inFlix
//
//  Created by Franco Tume on 11/4/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation

struct PropertyKey {
    static let unitKey = "unit"
    static let showIdKey = "showId"
    static let showTitleKey = "showTittle"
    static let releaseYearKey = "releaseYear"
    static let ratingKey = "rating"
    static let categoryKey = "category"
    static let showCastKey = "showCast"
    static let directorKey = "director"
    static let summaryKey = "summary"
    static let posterURLKey = "posterURL"
    static let mediaTypeKey = "mediaType"
    static let runtimeKey = "runtime"
    static let isFavoriteKey = "isFavorite"
}

class Movie: NSObject, NSCoding {
    let unit: Int
    let showId: Int
    let showTittle: String
    let releaseYear: String
    let rating: String
    let category: String
    let showCast: String
    let director: String
    let summary: String
    let posterURL: String
    let mediaType: Int
    let runtime: String
    var isFavorite: Bool = false
    
    init(unit: Int, showId: Int, showTittle: String, releaseYear: String, rating: String, category: String, showCast: String, director: String, summary: String, posterURL: String, mediaType: Int, runtime: String, isFavorite: Bool) {
        self.unit = unit
        self.showId = showId
        self.showTittle = showTittle
        self.releaseYear = releaseYear
        self.rating = rating
        self.category = category
        self.showCast = showCast
        self.director = director
        self.summary = summary
        self.posterURL = posterURL
        self.mediaType = mediaType
        self.runtime = runtime
        self.isFavorite = isFavorite
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let unit = aDecoder.decodeInteger(forKey: PropertyKey.unitKey) as? Int,
            let showId = aDecoder.decodeInteger(forKey: PropertyKey.showIdKey) as? Int,
            let showTittle = aDecoder.decodeObject(forKey: PropertyKey.showTitleKey) as? String,
            let releaseYear = aDecoder.decodeObject(forKey: PropertyKey.releaseYearKey) as? String,
            let rating = aDecoder.decodeObject(forKey: PropertyKey.ratingKey) as? String,
            let category = aDecoder.decodeObject(forKey: PropertyKey.categoryKey) as? String,
            let showCast = aDecoder.decodeObject(forKey: PropertyKey.showCastKey) as? String,
            let director = aDecoder.decodeObject(forKey: PropertyKey.directorKey) as? String,
            let summary = aDecoder.decodeObject(forKey: PropertyKey.summaryKey) as? String,
            let posterURL = aDecoder.decodeObject(forKey: PropertyKey.posterURLKey) as? String,
            let mediaType = aDecoder.decodeInteger(forKey: PropertyKey.mediaTypeKey) as? Int,
            let runtime = aDecoder.decodeObject(forKey: PropertyKey.runtimeKey) as? String ,
            let isFavorite = aDecoder.decodeBool(forKey: PropertyKey.isFavoriteKey) as? Bool else {
                return nil
        }
        
        self.init(unit: unit, showId: showId, showTittle: showTittle, releaseYear: releaseYear, rating: rating, category: category, showCast: showCast, director: director, summary: summary, posterURL: posterURL, mediaType: mediaType, runtime: runtime, isFavorite: isFavorite)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(unit, forKey: PropertyKey.unitKey)
        aCoder.encode(showId, forKey: PropertyKey.showIdKey)
        aCoder.encode(rating, forKey: PropertyKey.ratingKey)
        aCoder.encode(category, forKey: PropertyKey.categoryKey)
        aCoder.encode(showCast, forKey: PropertyKey.showCastKey)
        aCoder.encode(director, forKey: PropertyKey.directorKey)
        aCoder.encode(summary, forKey: PropertyKey.summaryKey)
        aCoder.encode(posterURL, forKey: PropertyKey.posterURLKey)
        aCoder.encode(mediaType, forKey: PropertyKey.mediaTypeKey)
        aCoder.encode(runtime, forKey: PropertyKey.runtimeKey)
        aCoder.encode(showTittle, forKey: PropertyKey.showTitleKey)
        aCoder.encode(releaseYear, forKey: PropertyKey.releaseYearKey)
        aCoder.encode(isFavorite, forKey: PropertyKey.isFavoriteKey)
    }
    
    static var DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static var ArchiveURL = DocumentsDirectory.appendingPathComponent("favoriteMovies")
}
