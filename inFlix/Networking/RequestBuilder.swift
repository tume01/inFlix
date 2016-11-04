//
//  RequestBuilder.swift
//  Opear
//
//  Created by christian on 5/31/16.
//  Copyright © 2016 Opear. All rights reserved.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

class RequestBuilder {
    
    var configuration = Configuration()
    
    init(){
        
    }
    
    fileprivate func URLForAPIPath(_ path: String, query: [String: Any]) -> URL {
        var url: URL
        if query.count > 0 {
            let params = query.map{(key, value) in "\(key)=\(value)" }
            let queryString = "?"+params.joined(separator: "&").addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
            url = URL(string: configuration.environment.baseURL+path+queryString)!
        } else {
            url = URL(string: configuration.environment.baseURL+path)!
        }
        
        return url
    }
    
    fileprivate func buildRequestWithURL(_ url : URL, method: String, withToken token: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        return request
    }
    
    func makeRequest(with parameters: [String: Any], path: String, token: String, method: HTTPMethods) -> URLRequest {
        
        var request: URLRequest
        let url: URL
        let data: Data?
        
        switch method {
        case .get:
            url = URLForAPIPath(path, query: parameters)
            data = nil
        default:
            url = URLForAPIPath(path, query: [:])
            try! data = JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        request = buildRequestWithURL(url, method: method.rawValue, withToken: token)
        request.httpBody = data
        
        return request
    }
    
}
