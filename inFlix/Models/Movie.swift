//
//  Movie.swift
//  inFlix
//
//  Created by Franco Tume on 11/4/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation

class Movie {
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
    
    init(unit: Int, showId: Int, showTittle: String, releaseYear: String, rating: String, category: String, showCast: String, director: String, summary: String, posterURL: String, mediaType: Int, runtime: String) {
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
    }
}
