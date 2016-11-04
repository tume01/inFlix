//
//  MoviesService.swift
//  inFlix
//
//  Created by Franco Tume on 11/4/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation

class MoviesService {
    class func sharedInstance() -> MoviesService {
        struct Singleton {
            static var sharedInstance = MoviesService()
        }
        return Singleton.sharedInstance
    }
    
    func getMovies(filters: [String:String], completionHandler: @escaping (_ result: NetworkResult<Any>) -> Void) {
        var movies = [Movie]()
        let request = RequestBuilder().makeRequest(with: filters, path: "", token: "", method: HTTPMethods.get)
        
        let task = NetworkManager.sharedInstance().dataTask(with: request) {
            networkResult in
            
            switch networkResult {
            case .success(let result):
                for(value) in (result as! [[String: Any]]) {
                    if let movie = Movie(json: value) {
                        movies.append(movie)
                    }
                }
                completionHandler(NetworkResult.success(result: movies))
            case .error:
                completionHandler(networkResult)
            }
        }
        
        task.resume()
    }
}

extension Movie {
    convenience init?(json: [String: Any]) {
        guard let unit = json["unit"] as? Int,
            let showID = json["show_id"] as? Int,
            let showTittle = json["show_title"] as? String,
            let releaseYear = json["release_year"] as? String,
            let rating = json["rating"] as? String,
            let category = json["category"] as? String,
            let showCast = json["show_cast"] as? String,
            let director = json["director"] as? String,
            let summary = json["summary"] as? String,
            let posterURL = json["poster"] as? String,
            let mediaType = json["mediatype"] as? Int,
            let runtime = json["runtime"] as? String else {
                return nil
        }
        self.init(unit: unit, showId: showID, showTittle: showTittle, releaseYear: releaseYear, rating: rating, category: category, showCast: showCast, director: director, summary: summary, posterURL: posterURL, mediaType: mediaType, runtime: runtime)
    }
}
