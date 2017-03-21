//
//  GAreaLargeSearchResults.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/19.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation
import SwiftyJSON

struct GAreas {
    var garea_large: [GArea] = []
}

struct GArea {
    var areacode_l: String?
    var areaname_l: String?
    var pref: Pref?
}

struct Pref {
    var pref_code: String?
    var pref_name: String?
}

final class GAreaLargeSearchResults {
    
    /// pref_nameが"東京都"の要素だけ取得する
    static func mapping(json: JSON) -> GAreas? {
        var gAreas = GAreas()
        var gArea = GArea()
        var pref = Pref()
        
        if let garea_large = json["garea_large"].array {
            
            garea_large.forEach{
                gArea.areacode_l = $0["areacode_l"].string
                gArea.areaname_l = $0["areaname_l"].string
                
                pref.pref_code = $0["pref"]["pref_code"].string
                pref.pref_name = $0["pref"]["pref_name"].string
                
                gArea.pref = pref
                
                if gArea.pref?.pref_name == "東京都" {
                    gAreas.garea_large.append(gArea)
                }
            }
        }
        return gAreas
    }
}
