//
//  GAreaLargeSearchAPI.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/19.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation

final class GAreaLargeSearchAPI {
    
    var loadable: GAreaLargeSearchLoadable?
    
    func fetch() {
        
        let params = GAreaLargeSearchParamsBuilder.create()
        let router = Router.GAreaLargeSearchAPI(params)
        
        if APIClient.isOnline() == false {
            Logger.error(message: "オフライン")
            return
        }
        
        APIClient.request(router: router) { [weak self] (response) in
            
            guard let weakSelf = self else { return }
            
            switch response {
            case .Success(let result, let statusCode):
                
                if let statusCode = statusCode {
                    print(statusCode)
                }
                
                guard let gAreaLargeSearchResults = GAreaLargeSearchResults.mapping(json: result) else { return }
                
                let status = weakSelf.setResult(result: gAreaLargeSearchResults)
                weakSelf.loadable?.setStatus(status: status)
                
                break
            case .Failure(let error, let statusCode):
                
                if let statusCode = statusCode {
                    print(statusCode)
                }
                
                weakSelf.loadable?.setStatus(status: .error(error))
            }
        }
    }
    
    /// Result zero or not
    private func setResult(result: GAreas) -> GAreaLargeSearchStatus {
        return result.garea_large.count > 0 ? .normal(result) : .noData
    }
}
