//
//  GNaviBaseParamsBuilder.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/18.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation
import Keys

final class GNaviBaseParamsBuilder {
    
    static func create() -> [String: Any] {
        return ["keyid" : Keys.GnaviApiDemoKeys().gnaviApiKey,
                "format": "json"]
    }
}
