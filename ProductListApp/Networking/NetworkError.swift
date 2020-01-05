//
//  NetworkError.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/20/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case timeoutError
    case lostInternetConnection
    case notConnectedToInternet
    case cannotDecodeData
    case cannotParseResponse(parseError: Error)
    case unknownError
    
    init(errorCode: Int) {
        switch errorCode {
        case NSURLErrorTimedOut:
            self = .timeoutError
        case NSURLErrorNetworkConnectionLost:
            self = .lostInternetConnection
        case NSURLErrorNotConnectedToInternet:
            self = .notConnectedToInternet
        case NSURLErrorCannotDecodeRawData:
            self = .cannotDecodeData
        default:
            self = .unknownError
        }
    }
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .timeoutError:
            return "Request is timed out"
        case .lostInternetConnection:
            return "Internet Connection was lost"
        case .notConnectedToInternet:
            return "Check Internet connection"
        case .cannotDecodeData:
            return "Cannot get data"
        default:
            return "Something went wrong"
        }
    }
}

