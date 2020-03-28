//
//  URLSessionExtension.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import Foundation

extension URLSession {
    
    func syncRequest(request: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        let task = self.dataTask(with: request) { data, response, error in
            semaphore.signal()
            completion(data, response, error)
            
        }
        task.resume()
        semaphore.wait()
        
    }
    
    func asyncRequest(request: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let task = self.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
        
    }
    
}
