//
//  UniverseImageAPI.swift
//  UniverseImagery
//
//  Created by Bharath on 04/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation

enum UniverseImageAPIError: Error {
    case invalidResponse
    case noResponse
    case invalidData
    case noData
    case unknown
    case invalidURL
    case parsingFailure
}


class UniverseImageAPI {
    
    func fetchMarsRoverImagery(forEndpoint endPoint: UniverseImageryEndpoint, withCompletionHandler handler: @escaping (([UniverseImageryRoverData]?, Error?) -> Void)) {
        
        let urlReq: URLRequest? = endPoint.urlRequest
        
        guard let request = urlReq else {
            handler(nil, UniverseImageAPIError.invalidURL)
            return
        }
        
        let session: URLSession = URLSession(configuration: .default)
        session.dataTask(with: request, completionHandler: { (responseData: Data?, urlResp: URLResponse?, error: Error?) -> Void in
            
            if let error = error {
                //API has returned an error for us. Just call the handler with the error.
                handler(nil, error)
            }
            else {
                //No error.
                //Check the response.
                if let httpResponse = urlResp as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 200 {
                        //Valid response.
                        //Now, check the presence of data.
                        guard let respData = responseData else {
                            handler(nil, UniverseImageAPIError.noData)
                            return
                        }
                        
                        //All fine
                        let decoder: JSONDecoder = JSONDecoder()
                        do {
                            let apiResult: UniverseRoverAPIResult =  try decoder.decode(UniverseRoverAPIResult.self, from: respData)
                            handler(apiResult.photos, nil)
                        }
                        catch (let err) {
                            //handler(nil, UniverseImageAPIError.parsingFailure)
                            handler(nil, err)
                        }
                    }
                    else {
                        //Invalid response.
                        handler(nil, UniverseImageAPIError.invalidResponse)
                    }
                }
                else {
                    //No response received.
                    handler(nil, UniverseImageAPIError.noResponse)
                }
            }
            
        }).resume()
        
        
    }
    
}
