//
//  ErrorCode.swift
//  Opear
//
//  Created by christian on 6/3/16.
//  Copyright © 2016 Opear. All rights reserved.
//

import Foundation

struct ErrorCode {
    static let UnnknownError        = -1
    static let InternalError        = 1
    static let AuthenticationError  = 11
    static let UserNotFound         = 12
    static let ExpiredToken         = 21
    static let InvalidToken         = 22
    static let AbsentToken          = 23
    static let ExperidRefreshToken  = 24
    static let DataValidation       = 31
    static let FacebookTokenInvalid = 41
    static let UUIDNotFound         = 51
    static let DeviceNotLinked      = 52
    static let KeyInvalid           = 61
    static let SubscriptionRequired = 62
}
