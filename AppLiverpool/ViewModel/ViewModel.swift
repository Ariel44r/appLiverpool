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
    let userDefaultKey: String = "lastQueryData"
    var lastDataQuery: APIResponse? {
        guard let jsonString = UserDefaults.standard.value(forKey: userDefaultKey) as? String,
        let data = jsonString.data(using: .utf8),
        let object = try? JSONDecoder().decode(APIResponse.self, from: data),
        let apiResponse = object as? APIResponse else { return nil }
        return apiResponse
        
    }
    
    private override init() { }
    var apiResponse: APIResponse!
    
    class func reset() {
        ViewModel.shared = ViewModel()
    }
    
    let baseURL: String = "https://shoppapp.liverpool.com.mx/appclienteservices/services/v3"
    func getItems(with searchText: String, pageNumber: Int, itemsPerPage: Int, onSuccess: @escaping Response<APIResponse>, onError: @escaping ErrorHandler<APIError>) {
        let endPoint: String = "\(baseURL)/plp?force-plp=true&search-string=\(searchText)&page-number=\(pageNumber)&number-of-items-per-page=\(itemsPerPage)"
        sendHTTPRequest(with: [ .endPoint(endPoint), .mimeType(.urlEncoded), .method(.GET) ], onSuccess: { [weak self] (response: APIResponse) in
            self?.apiResponse = response
            onSuccess(response)
        }, onError: onError)
    }
    func saveLastData(response: APIResponse) {
        guard let jsonString: String = response.encode() else { return }
        UserDefaults.standard.set(jsonString, forKey: userDefaultKey)
        
    }
}

// MARK: Computed vars & transform methods
extension ViewModel {
    var records: [Record]? {
        return apiResponse?.plpResults?.records
        
    }
    
    var numberOfItems: Int? {
        return apiResponse?.plpResults?.records.count
        
    }
}

extension ViewModel {
    func set(with view: ItemCollectionViewCell) {
        DispatchQueue.main.async { [weak self] in
            guard let record = self?.lastDataQuery?.plpResults?.records?[view.tag] else { return }
            view.containerView?.makeViewWith(features: [.rounded, .bordered(.lightGray, 1)])
            view.imageViewCell?.getImage(from: record.smImage ?? "")
            view.titleLabel?.text = record.productDisplayName ?? ""
            view.priceLabel?.text = "\(record.listPrice ?? 0)".currencyInputFormatting()
            view.placeLabel?.text = record.marketplaceSLMessage ?? ""
        }
    }
    func set(with view: ItemTableViewCell) {
        guard let record = records?[view.tag] else { return }
        view.containerView?.makeViewWith(features: [.rounded, .bordered(.lightGray, 1)])
        view.imageViewCell?.getImage(from: record.smImage ?? "")
        view.titleLabel?.text = record.productDisplayName ?? ""
        view.priceLabel?.text = "\(record.listPrice ?? 0)".currencyInputFormatting()
        view.placeLabel?.text = record.marketplaceSLMessage ?? ""
    }
}
