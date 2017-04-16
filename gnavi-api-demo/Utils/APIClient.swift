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
    
    static func request(router : Router,
                        completionHandler: @escaping (Result<JSON>) -> () = {_ in}) {
        
        Alamofire.request(router).responseString { (response) in
            switch response.result {
            case .success(let value):
                let jsonObject = JSON.init(parseJSON: value)
                let statusCode = response.response?.statusCode
                
                completionHandler(Result.Success((jsonObject, statusCode)))
                
                print("statusCode: \(statusCode)") // the status code
                return
                
            case .failure:
                
                if let error = response.result.error {
                    let statusCode = response.response?.statusCode
                    completionHandler(Result.Failure((error, statusCode)))
                } else {
                    fatalError("error is nil.")
                }
            }
            
            var statusCode = response.response?.statusCode
            if let error = response.result.error as? AFError {
                statusCode = error._code // statusCode private
                switch error {
                case .invalidURL(let url):
                    print("Invalid URL: \(url) - \(error.localizedDescription)")
                case .parameterEncodingFailed(let reason):
                    print("Parameter encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .responseValidationFailed(let reason):
                    print("Response validation failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                    
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        print("Downloaded file could not be read")
                    case .missingContentType(let acceptableContentTypes):
                        print("Content Type Missing: \(acceptableContentTypes)")
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    case .unacceptableStatusCode(let code):
                        print("Response status code was unacceptable: \(code)")
                        statusCode = code
                    }
                case .responseSerializationFailed(let reason):
                    print("Response serialization failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                }
                
                print("Underlying error: \(error.underlyingError)")
            } else if let error = response.result.error as? URLError {
                print("URLError occurred: \(error)")
            } else {
                print("Unknown error: \(response.result.error)")
            }
            
            let statusCodeString = statusCode?.description ?? "-"
            print("statusCode: \(statusCodeString)") // the status code
            
        }
    }
}
