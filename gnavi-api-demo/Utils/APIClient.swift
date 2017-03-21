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

enum Result<JSON> {
    case Success(JSON)
    case Failure(Error)
}

final class APIClient: DataRequest {
    
    static func request(router : Router,
                        completionHandler: @escaping (Result<JSON>) -> () = {_ in}) {
        
        Alamofire.request(router).responseSwiftyJSON { (response) in
            switch response.result {
            case .success(let value):
                
                completionHandler(Result.Success(value))
            case .failure:
                
                if let error = response.result.error {
                    completionHandler(Result.Failure(error))
                } else {
                    fatalError("error is nil.")
                }
            }
        }
    }
}
