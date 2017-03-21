//
//  RestSearchAPI.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/20.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation

class RestSearchAPI: NSObject {
    
    private let hit_per_page = 50
    private var requestCount = 1
    private var totalCount = 1
    
    var isLoading = false
    var loadable: RestSearchLoadable?
    
    func load(areacode_l: String) {
        
        isLoading = true
        
        let params = RestSearchParamsBuilder.create(areacode_l: areacode_l,
                                                    hit_per_page: self.hit_per_page,
                                                    offset_page: requestCount)
        let router = Router.RestSearchAPI(params)
        
        APIClient.request(router: router) { [weak self] (response) in
            
            guard let weakSelf = self else { return }
            
            switch response {
            case .Success(let result):
                
                guard let restSearchResults = RestSearchResults.mapping(json: result) else { return }
                
                let status = weakSelf.setResult(result: restSearchResults)
                weakSelf.loadable?.setStatus(status: status)
                
                break
            case .Failure(let error):
                
                weakSelf.loadable?.setStatus(status: .error(error))
            }
            weakSelf.isLoading = false
        }
    }
    
    /// Result zero or not
    private func setResult(result: Restaurants) -> RestSearchStatus {
        return result.restaurant.count > 0 ? .normal(result) : .noData
    }
    
    // MARK:- Manage request count
    
    /// Reset request count
    func reset() {
        requestCount = 1
    }
    
    /// Increment request count
    func increment() {
        requestCount += 1
    }
    
    /// Update total count
    func update(total: Int) {
        totalCount = total
    }
    
    func hasMoreRequest() -> Bool {
        return totalCount > requestCount * hit_per_page
    }
}
