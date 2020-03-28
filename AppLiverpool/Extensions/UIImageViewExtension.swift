//
//  UIImageViewExtension.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func getImage(from url: String) {
        DispatchQueue.global(qos: .background).async {
            if let image = ImageCache.shared.getImage(for: url) {
                DispatchQueue.main.async { [weak self] in
                    debugPrint("🏠")
                    self?.image = image

                }
            } else {
                debugPrint("🚀")
                DispatchQueue.main.async { [weak self] in
                    let activityView = UIActivityIndicatorView(style: .medium)
                    guard let url = URL(string: url) else { return }
                    self?.addSubview(activityView)
                    activityView.center = self?.center ?? .zero
                    activityView.startAnimating()
                    activityView.color = .white
                    DispatchQueue.global(qos: .background).async {
                        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                            if let data = data, let image = UIImage(data: data) {
                                DispatchQueue.main.async { [weak self] in
                                    self?.image = image
                                    if let data = image.base64.data(using: .utf8) {
                                        ImageCache.shared.cacheMy(object: data, for: url.absoluteString)
                                        
                                    }
                                    activityView.stopAnimating()
                                    activityView.removeFromSuperview()
                                    
                                }
                            } else {
                                DispatchQueue.main.async { [weak self] in
                                    activityView.stopAnimating()
                                    activityView.removeFromSuperview()
//                                    self?.image = #imageLiteral(resourceName: "shadow_asset_details_page")
                                    
                                }
                            }
                        })
                        task.resume()
                    }
                }
            }
        }
    }

}

class ImageCache: NSCache<NSString, NSData> {
    static let shared: ImageCache = ImageCache()
    private override init() { }
    
    func cacheMy(object: Data, for key: String) {
        setObject(object as NSData, forKey: key as NSString)
        
    }
    
    func getMyObject(for key: NSString) -> Data? {
        return object(forKey: key) as Data?
        
    }
    
    func getImage(for key: String) -> UIImage? {
        if let data64 = getMyObject(for: key as NSString),
        let imageData = Data(base64Encoded: data64),
        let image = UIImage(data: imageData) {
            return image
            
        }
        return nil
    }
    
    func deleteCachedObject(for key: String) {
        removeObject(forKey: key as NSString)
        
    }
        
}

extension UIImage {
    var base64: String {
        guard let data: Data = self.pngData() as Data? else { return "" }
        return data.base64EncodedString()

    }
}
