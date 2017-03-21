//
//  Router.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/18.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "https://api.gnavi.co.jp/"
    
    /// エリアLマスタ取得API
    case GAreaLargeSearchAPI([String: Any])
    
    /// レストラン検索API
    case RestSearchAPI([String: Any])
    
    func asURLRequest() throws -> URLRequest {
        
        let (method, path, parameters): (HTTPMethod, String, [String: Any]) = {
            
            switch self {
            case .GAreaLargeSearchAPI(let params):
                return (.get, "master/GAreaLargeSearchAPI/20150630/", params)
            case .RestSearchAPI(let params):
                return (.get, "RestSearchAPI/20150630/", params)
            }
        }()
        
        if let url = URL(string: Router.baseURLString) {
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        } else {
            fatalError("url is nil.")
        }
    }
}
