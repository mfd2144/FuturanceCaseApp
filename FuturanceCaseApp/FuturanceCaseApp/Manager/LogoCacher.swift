//
//  LogoCacher.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 24.08.2022.
//

import Foundation
import UIKit

final class LogoCacher {
    static let shared = LogoCacher()
    private let cache = NSCache<NSString, NSData>()
    private let dolarImage = UIImage(systemName: "dollarsign.circle")!.withTintColor(buttonGreen, renderingMode: .alwaysOriginal)
    
    private init() {}
    func checkImage(for currencyName: String, from urlString: String?, completion:@escaping (UIImage) -> Void) {
        // there isn't url information
        guard let urlString = urlString else {
            completion(dolarImage)
            return}
        if let imageData = cache.object(forKey: currencyName as NSString) {
            let image = UIImage(data: imageData as Data)
             completion(image ?? UIImage(systemName: "timelapse")!)
        } else {
            appContainer.manager.getImage(kind: .image(urlString)) {[weak self] data, error in
                guard let self = self else { return }
                if error != nil {
                    completion(UIImage(systemName: "ant.circle")!.withTintColor(buttonRed, renderingMode: .alwaysTemplate))
                } else {
                    guard let data = data, let image = UIImage(data: data) else {
                        guard let dolarImageData = self.dolarImage.jpegData(compressionQuality: 1) else { return }
                        self.cache.setObject(dolarImageData as NSData, forKey: currencyName as NSString)
                        completion(self.dolarImage)
                        return
                    }
                    self.cache.setObject(data as NSData, forKey: currencyName as NSString)
                    completion(image)
                }
            }
        }
    }
}
