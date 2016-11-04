//
//  Configuration.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/13/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation

struct Configuration {
    
    enum Environment: String {
        case production = "http://netflixroulette.net/prod/api/api.php"
        case dev = "http://netflixroulette.net/api/api.php"
        
        var baseURL: String { return rawValue}
    }
    
    let environment = Environment.dev
    
}
