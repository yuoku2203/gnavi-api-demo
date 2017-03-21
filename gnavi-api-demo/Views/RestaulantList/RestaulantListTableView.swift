//
//  RestaulantListTableView.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/21.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

final class RestaulantListTableView: NSObject {
    var restaurants = Restaurants()
    
    func add(newRestaurants: Restaurants) {
        
        if restaurants.restaurant.count == 0 {
            restaurants = newRestaurants
        } else {
            restaurants.restaurant += newRestaurants.restaurant
        }
    }
}

// MARK:- UITableViewDataSource
extension RestaulantListTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.restaurant.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaulantListTableViewCell.identifier,
                                                 for: indexPath) as! RestaulantListTableViewCell
        cell.restaurant = restaurants.restaurant[indexPath.row]
        return cell
    }
}
