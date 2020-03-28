//
//  Wrappable.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import Foundation

class Wrappable: NSObject, Codable {
    func encode<T>() -> T? {
        if let optionalData = try? JSONEncoder().encode(self) as? T,
            let data = optionalData as T? {
            return data
            
        } else if let optionalData = try? JSONEncoder().encode(self) as JSONData?,
            let data = optionalData as JSONData?,
            let string = JSONString(data: data, encoding: .utf8) as? T {
            return string
            
        } else if let optionalData = try? JSONEncoder().encode(self) as JSONData?,
            let data = optionalData as JSONData?,
            let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? T {
            return jsonDictionary
            
        } else {
            return nil
            
        }
    }
    
    func toJSON() -> JSON? {
        guard let json: JSON = self.encode() else { return nil }
        return json
        
    }
    
    func toJSONString() -> JSONString? {
        guard let string: JSONString = self.encode() else { return nil }
        return string
        
    }
    
    func toJSONData() -> JSONData? {
        guard let data: JSONData = self.encode() else { return nil }
        return data
        
    }
}
class APIError: NSError { }

typealias JSON = [String: Any]
public typealias JSONData = Data
public typealias JSONString = String
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
