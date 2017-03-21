//
//  RestSearchLoadable.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/20.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation

enum RestSearchStatus {
    case none
    case normal(Restaurants)
    case noData
    case error(Error)
}

protocol RestSearchLoadable {
    func setStatus(status: RestSearchStatus)
}
