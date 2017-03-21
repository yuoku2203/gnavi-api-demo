//
//  GNaviBaseParamsBuilderTests.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/19.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import XCTest
import Keys
@testable import gnavi_api_demo

class GNaviBaseParamsBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreate() {
        
        let params = GNaviBaseParamsBuilder.create() as! [String: String]
        
        XCTAssertEqual(GNaviBaseParamsBuilder.create().count, 2)
        XCTAssertEqual(params["keyid"], Keys.GnaviApiDemoKeys().gnaviApiKey)
        XCTAssertEqual(params["format"], "json")
    }
}
