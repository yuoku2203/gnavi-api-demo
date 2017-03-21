//
//  RestSearchParamsBuilder.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/20.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation

final class RestSearchParamsBuilder: NSObject {
    
    static func create(areacode_l: String, hit_per_page: Int, offset_page: Int) -> [String: Any] {
        
        var params = GNaviBaseParamsBuilder.create()
        params["areacode_l"] = areacode_l
        params["hit_per_page"] = hit_per_page
        params["offset_page"] = offset_page
        return params
    }
}
