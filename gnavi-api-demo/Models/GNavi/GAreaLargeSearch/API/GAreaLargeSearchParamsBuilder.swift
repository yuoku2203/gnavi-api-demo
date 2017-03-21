//
//  GAreaLargeSearchParamsBuilder.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/18.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation

final class GAreaLargeSearchParamsBuilder: NSObject {
    
    static func create() -> [String: Any] {
        
        var params = GNaviBaseParamsBuilder.create()
        params["lang"] = "ja"
        return params
    }
}
