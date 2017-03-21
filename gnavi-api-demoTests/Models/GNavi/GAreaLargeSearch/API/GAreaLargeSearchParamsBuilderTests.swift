//
//  GAreaLargeSearchParamsBuilderTests.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/19.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
@testable import gnavi_api_demo

class GAreaLargeSearchParamsBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreate() {
        
        let params = GAreaLargeSearchParamsBuilder.create() as! [String: String]
        
        XCTAssertEqual(GAreaLargeSearchParamsBuilder.create().count, 3)
        XCTAssertEqual(params["lang"], "ja")
    }
}
