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
    
    var localizedDescription: String {
        
        switch self {
            case .invalidResponse: return "Invalid response. Please try again"
            case .noResponse: return "Failed to receive reponse in time. Please try again after a while"
            case .invalidData: return "Unreadable data received"
            case .noData: return "No data received"
            case .invalidURL: return "Could not connect to the server. Please try again after some time"
            case .parsingFailure: return "Unreadable data received"
            default: return "An unknown error has occurred"
        }
    }
}


class UniverseImageAPI {
    
    @discardableResult func fetchMarsRoverImagery(forEndpoint endPoint: UniverseImageryEndpoint, withCompletionHandler handler: @escaping (([UniverseImageryRoverData]?, Error?) -> Void)) -> URLSessionDataTask? {
        
        let urlReq: URLRequest? = endPoint.urlRequest
        
        guard let request = urlReq else {
            handler(nil, UniverseImageAPIError.invalidURL)
            return nil
        }
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (responseData: Data?, urlResp: URLResponse?, error: Error?) -> Void in
            
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
                        catch {
                            handler(nil, UniverseImageAPIError.parsingFailure)
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
            
        })
        dataTask.resume()
       
        return dataTask
        
    }
    
    
    @discardableResult func fetchEarthImagery(forEndpoint endPoint: UniverseImageryEndpoint, withCompletionHandler handler: @escaping ((UniverseImageryEarthData?, Error?) -> Void)) -> URLSessionDataTask? {
           
           let urlReq: URLRequest? = endPoint.urlRequest
           
           guard let request = urlReq else {
               handler(nil, UniverseImageAPIError.invalidURL)
               return nil
           }
           
           let session: URLSession = URLSession(configuration: .default)
           let dataTask: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (responseData: Data?, urlResp: URLResponse?, error: Error?) -> Void in
               
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
                               let earthData: UniverseImageryEarthData =  try decoder.decode(UniverseImageryEarthData.self, from: respData)
                               handler(earthData, nil)
                           }
                           catch {
                               handler(nil, UniverseImageAPIError.parsingFailure)
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
               
           })
           dataTask.resume()
          
           return dataTask
           
       }
    
}
