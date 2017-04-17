//
//  APIClient.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/18.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON

enum Result<VALUE> {
    case Success((VALUE, Int?))
    case Failure((Error, Int?))
}

final class APIClient: DataRequest {
    
    
    /// 端末の通信状態を取得
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func isOnline() -> Bool {
        
        if let reachabilityManager = NetworkReachabilityManager() {
            reachabilityManager.startListening()
            return reachabilityManager.isReachable
        }
        return false
    }
    
    /// API Request
    static func request(router: Router,
                        completionHandler: @escaping (Result<JSON>) -> () = {_ in}) {
        
        Alamofire.request(router).responseSwiftyJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                let statusCode = response.response?.statusCode
                Logger.info(message: "HTTP status code: \(statusCode)")
                completionHandler(Result.Success((value, statusCode)))
                return
                
            case .failure:
                var statusCode = response.response?.statusCode
                if let error = response.result.error {
                    Logger.info(message: "HTTP status code: \(statusCode)")
                    completionHandler(Result.Failure((error, statusCode)))
                    return
                }
                
                if let error = response.result.error as? AFError {
                    statusCode = error._code
                    switch error {
                        
                    case .invalidURL(let url):
                        Logger.error(message: "Invalid URL: \(url) - \(error.localizedDescription)")
                        
                    case .parameterEncodingFailed(let reason):
                        Logger.error(message: "Parameter encoding failed: \(error.localizedDescription)")
                        Logger.error(message: "Failure Reason: \(reason)")
                        
                    case .multipartEncodingFailed(let reason):
                        Logger.error(message: "Multipart encoding failed: \(error.localizedDescription)")
                        Logger.error(message: "Failure Reason: \(reason)")
                        
                    case .responseValidationFailed(let reason):
                        Logger.error(message: "Response validation failed: \(error.localizedDescription)")
                        Logger.error(message: "Failure Reason: \(reason)")
                        
                        switch reason {
                            
                        case .dataFileNil, .dataFileReadFailed:
                            Logger.error(message: "Downloaded file could not be read")
                            
                        case .missingContentType(let acceptableContentTypes):
                            Logger.error(message: "Content Type Missing: \(acceptableContentTypes)")
                            
                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                            Logger.error(message: "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                            
                        case .unacceptableStatusCode(let code):
                            Logger.error(message: "Response status code was unacceptable: \(code)")
                            statusCode = code
                        }
                        
                    case .responseSerializationFailed(let reason):
                        Logger.error(message: "Response serialization failed: \(error.localizedDescription)")
                        Logger.error(message: "Failure Reason: \(reason)")
                    }
                    
                    Logger.error(message: "Underlying error: \(error.underlyingError)")
                } else if let error = response.result.error as? URLError {
                    Logger.error(message: "URL error: \(error)")
                } else {
                    Logger.error(message: "Unknown error: \(response.result.error)")
                }
                
                Logger.info(message: "HTTP status code: \(statusCode)")
            }
        }
    }
}
