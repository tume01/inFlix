//
//  NetworkResult.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/14/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

enum  NetworkResult<T> {
    case success(result: T)
    case error(error: Error)
}
