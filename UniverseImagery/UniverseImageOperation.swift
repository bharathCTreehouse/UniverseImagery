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
    
    let imageUrl: URL
    let completionHandler: ((UIImage?, Error?, Bool) -> Void)
    let uniqueIdentifier: String?
    
    
    init(withImageUrl url: URL, uniqueIdentifier id: String? = nil,  completionHandler handler: @escaping ((UIImage?, Error?, Bool) -> Void)) {
        
        imageUrl = url
        completionHandler = handler
        uniqueIdentifier = id
    }
    
    
    override func main() {
        
        if isCancelled == true {
            completionHandler(nil, nil, true)
        }
        do {
            let imageData: Data = try Data.init(contentsOf: imageUrl)
            if isCancelled == true {
                completionHandler(nil, nil, true)
            }
            if imageData.isEmpty == false {
                let image: UIImage? = UIImage(data: imageData)
                if let image = image {
                    completionHandler(image, nil, false)
                }
                else {
                    completionHandler(image, UniverseImageOperationError.invalidImageData, false)
                }
            }
            else {
                //Data empty. Error out.
                completionHandler(nil, UniverseImageOperationError.noImageData, false)
            }
        }
        catch (let error) {
            if isCancelled == true {
                completionHandler(nil, nil, true)
            }
            else {
                completionHandler(nil, error, false)
            }
        }
    }
    
}
