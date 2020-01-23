//
//  UniverseImageOperation.swift
//  UniverseImagery
//
//  Created by Bharath on 06/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation
import UIKit

enum UniverseImageOperationError: Error {
    case invalidImageData
    case noImageData
}

class UniverseImageOperation: Operation {
    
    var imageUrl: URL
    let completionHandler: ((UIImage?, String?, Error?, Bool) -> Void)
    let uniqueIdentifier: String?
    
    
    init(withImageUrl url: URL, uniqueIdentifier id: String? = nil,  completionHandler handler: @escaping ((UIImage?, String?, Error?, Bool) -> Void)) {
        
        imageUrl = url
        completionHandler = handler
        uniqueIdentifier = id
        
        if imageUrl.absoluteString.contains("https") == false {
            let tempUrlString = imageUrl.absoluteString.replacingOccurrences(of: "http", with: "https")
            imageUrl = URL(string: tempUrlString)!
        }
    }
    
    
    override func main() {
        
        if isCancelled == true {
            completionHandler(nil, uniqueIdentifier, nil, true)
        }
        do {

            let imageData: Data = try Data.init(contentsOf: imageUrl, options: [])
            if isCancelled == true {
                completionHandler(nil, uniqueIdentifier, nil, true)
            }
            else if imageData.isEmpty == false {
                print(imageData)
                let image: UIImage? = UIImage(data: imageData)
                if let image = image {
                    completionHandler(image, uniqueIdentifier, nil, isCancelled)
                }
                else {
                    completionHandler(image, uniqueIdentifier, UniverseImageOperationError.invalidImageData, isCancelled)
                }
            }
            else {
                //Data empty. Error out.
                completionHandler(nil, uniqueIdentifier, UniverseImageOperationError.noImageData, isCancelled)
            }
        }
        catch (let error) {
            completionHandler(nil, uniqueIdentifier, error, isCancelled)
        }
    }
    
}
