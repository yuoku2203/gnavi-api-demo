//
//  RestSearchResults.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/20.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Restaurants {
    var total_hit_count = 0
    var restaurant: [Restaurant] = []
}

struct Restaurant {
    var name: String?
    var station: String?
    var walk: Int?
    var address: String?
    var tel: String?
    var budget: String?
    var shop_image1: String?
}

final class RestSearchResults: NSObject {
    
    /// pref_nameが"東京都"の要素だけ取得する
    static func mapping(json: JSON) -> Restaurants? {
        var restaurants = Restaurants()
        var restaurant = Restaurant()
        
        restaurants.total_hit_count = json["total_hit_count"].intValue
        if let rest = json["rest"].array {
            
            rest.forEach{
                restaurant.name = $0["name"].string
                restaurant.station = $0["access"]["station"].string
                restaurant.walk = $0["access"]["walk"].intValue
                restaurant.address = $0["address"].string
                restaurant.tel = $0["tel"].string
                
                // ¥表記へ変換
                let formatter = NumberFormatter()
                formatter.numberStyle = .currency
                restaurant.budget = formatter.string(from: $0["budget"].numberValue)
                
                restaurant.shop_image1 = $0["image_url"]["shop_image1"].string
                
                restaurants.restaurant.append(restaurant)
            }
        }
        return restaurants
    }
}
