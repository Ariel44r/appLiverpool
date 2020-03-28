//
//  API.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import UIKit

class ViewModel: HTTPLayer {
    static var shared: ViewModel = ViewModel()
    private override init() { }
    class func reset() {
        ViewModel.shared = ViewModel()
    }
    
    let baseURL: String = "https://shoppapp.liverpool.com.mx/appclienteservices/services/v3/"
    func getItems(with searchText: String, pageNumber: Int, itemsPerPage: Int, onSuccess: @escaping Response<APIResponse>, onError: @escaping ErrorHandler<APIError>) {
        let endPoint: String = "\(baseURL)plp?force-plp=true&search-string=\(searchText)&page-number=\(pageNumber)&number-of-items-per-page=\(itemsPerPage)"
        sendHTTPRequest(with: [ .endPoint(endPoint), .mimeType(.urlEncoded), .method(.GET), .headers(["Content-Type": "application/json"]) ], onSuccess: onSuccess, onError: onError)
        
    }
}

extension ViewModel {
    func set(with view: UIView) {
        
    }
}
