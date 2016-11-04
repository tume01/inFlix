//
//  NetworkManager2.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/13/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation

class NetworkManager {
    
    var session = URLSession.shared
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (_ result: NetworkResult<Any>) -> Void) -> URLSessionDataTask {
        
        let dataTaskResult = self.session.dataTask(with: request, completionHandler: {
            optionalData, response, networkError in
            if let error = networkError {
                completionHandler(NetworkResult.error(error: error))
            } else if let data = optionalData, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                if let jsonError = JSONParser.errorFromJSON(jsonObject) {
                    completionHandler(NetworkResult.error(error: jsonError))
                } else {
                    completionHandler(NetworkResult.success(result: jsonObject))
                }
            }
        })
        
        return dataTaskResult
    }
    
    func getDataFromUrl(url: URL, completionHandler: @escaping (_ result: NetworkResult<Any>) -> Void) {
        
        self.session.dataTask(with: url, completionHandler: {
            optionalData, response, networkError in
            
            if let error = networkError {
                completionHandler(NetworkResult.error(error: error))
            }else if let data = optionalData {
                DispatchQueue.main.async() { () -> Void in
                    completionHandler(NetworkResult.success(result: data))
                }
                
            }
        }).resume()
    }
    
    class func sharedInstance() -> NetworkManager {
        struct Singleton {
            static var sharedInstance = NetworkManager()
        }
        return Singleton.sharedInstance
    }
}
