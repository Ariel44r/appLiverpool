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
        guard let record = records?[view.tag] else { return }
        view.containerView?.makeViewWith(features: [.rounded, .bordered(.lightGray, 1)])
        view.imageViewCell?.getImage(from: record.smImage ?? "")
        view.titleLabel?.text = record.productDisplayName ?? ""
        view.priceLabel?.text = "\(record.listPrice ?? 0)".currencyInputFormatting()
        
    }
}

extension String {
    func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        var amountWithPrefix = self
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100)*10)
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        return formatter.string(from: number)!
    }
    
    func set(with view: ItemTableViewCell) {
        
    }
}
