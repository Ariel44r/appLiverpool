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
//
//@objc class WrapperLayer: HTTPLayer {
//    func sendRequest<T: Wrappable>(with features: [RequestFeature], onSuccess: @escaping Response<T>, onError: @escaping ErrorHandler<APIError>) {
//        setRequest(with: features)
//        if let _ = HTTPLayer.token {
//            sendHTTPRequest(with: features, onSuccess: onSuccess, onError: onError)
//        } else { // time to fetch token data
//            
//        }
//    }
//}

class HTTPLayer: NSObject {
    var request: URLRequest!
    var tokenURL: String?
    static var token: String?
    
    func sendHTTPRequest<T: Wrappable>(with features: [RequestFeature], onSuccess: @escaping Response<T>, onError: @escaping ErrorHandler<APIError>) {
        self.setRequest(with: [.headers(["Authorization": "Bearer \(HTTPLayer.token ?? "")", "x-Ismock": "true"])])
        guard let request = request else { return }
        URLSession.shared.asyncRequest(request: request, completion: { data, response, error in
            if let data = data,
                let object = try? JSONDecoder().decode(T.self, from: data),
                let unwrappedObject = object as T? {
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 { // time to fetch token data
                    
                } else { onSuccess(unwrappedObject) }
            } else if let error = error as? APIError {
                onError(error)
                
            }
        })
    }
    
    func setRequest(with features: [RequestFeature]) {
        features.forEach {
            switch $0 {
            case .endPoint(let endPoint):
                guard let url = URL(string: endPoint) else { return }
                request = URLRequest(url: url)
                debugPrint("[REQUEST: \(endPoint)]")
            case .tokenURL(let url):        tokenURL = url
            case .mimeType(let mimeType):   request?.setValue(mimeType.rawValue, forHTTPHeaderField: "Content-Type")
            case .method(let method):       request?.httpMethod = method.rawValue
            case .inputData(let data):      request?.httpBody = data
            case .body(let json):           request?.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            case .headers(let headers):     request?.allHTTPHeaderFields = headers
            }
        }
    }
}
