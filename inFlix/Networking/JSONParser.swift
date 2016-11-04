//
//  JSONParser.swift
//  Opear
//
//  Created by christian on 5/31/16.
//  Copyright © 2016 Opear. All rights reserved.
//

import Foundation

class JSONParser {
    static let domain = "com.opear.Opear"
    static let codeRefreshToken = 1
    
    static func errorFromJSON (_ jsonObject: Any?) -> Error? {
        guard let jsonDictionary = jsonObject as? [String: Any] else {
            return nil
        }
        
        if let error =  jsonDictionary["error"] as? [String: AnyObject] {
            
            var userInfo = [String : AnyObject]()
            if let errorMessage = error["message"] as? String {
                userInfo[NSLocalizedDescriptionKey] = errorMessage as AnyObject?
            }
            if let errorReasons = error["reasons"] as? [String:String] {
                userInfo[NSLocalizedFailureReasonErrorKey] = errorReasons as AnyObject?
            }
            let errorCode = error["code"] as? Int ?? -1
            
            return NSError(domain: domain, code: errorCode, userInfo: userInfo)
            
        }
        else if let errorMessage = jsonDictionary["error"] as? String {
            
            let userInfo = [NSLocalizedDescriptionKey: errorMessage ]
            
            return NSError(domain: domain, code: -1, userInfo: userInfo)
        }
        
        if let refreshTokenValue = jsonDictionary["refresh-token"] as? String {
            let userInfo = [NSLocalizedDescriptionKey: refreshTokenValue ]
            
            return NSError(domain: domain, code: codeRefreshToken, userInfo: userInfo)
        }
        
        return nil
    }
}
