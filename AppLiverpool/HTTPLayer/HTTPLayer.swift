//
//  HTTPLayer.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import Foundation

class HTTPLayer: NSObject {
    var request: URLRequest!
    var tokenURL: String?
    
    func sendHTTPRequest<T: Wrappable>(with features: [RequestFeature], onSuccess: @escaping Response<T>, onError: @escaping ErrorHandler<APIError>) {
        setRequest(with: features)
        guard let request = request else { return }
        URLSession.shared.asyncRequest(request: request, completion: { data, response, error in
            if let data = data,
                let object = try? JSONDecoder().decode(T.self, from: data),
                let unwrappedObject = object as T? {
                onSuccess(unwrappedObject)
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
