//
//  Wrappable.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import Foundation

class Wrappable: NSObject, Codable { }
class APIError: NSError { }

typealias JSON = [String: Any]
typealias Response<T: Wrappable> = (T) -> Void
typealias ErrorHandler<T: NSError> = (T) -> Void

enum HTTPMethod: String {
    case GET="GET"
    case POST="POST"
    case HEAD="HEAD"
    case PUT="PUT"
    case DELETE="DELETE"
    case PATCH="PATCH"
}

enum MimeType: String {
    case urlEncoded="application/x-www-form-urlencoded"
    case json="application/json"
    
}

enum RequestFeature {
    case endPoint(String)
    case mimeType(MimeType)
    case method(HTTPMethod)
    case inputData(Data?)
    case body(JSON)
    case headers([String: String])
    case tokenURL(String)
}
