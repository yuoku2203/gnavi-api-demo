//
//  GAreaLargeSearchLoadable.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/18.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation

enum GAreaLargeSearchStatus {
    case none
    case normal(GAreas)
    case noData
    case error(Error)
}

protocol GAreaLargeSearchLoadable {
    func setStatus(status: GAreaLargeSearchStatus)
}
