//
//  AreaSelectTableView.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/20.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

final class AreaSelectTableView: NSObject {
    var areas = GAreas()
    
    func add(newAreas: GAreas) {
        areas = newAreas
    }
}

// MARK:- UITableViewDataSource
extension AreaSelectTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.garea_large.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AreaSelectTableViewCell.identifier,
                                                 for: indexPath) as! AreaSelectTableViewCell
        cell.area = areas.garea_large[indexPath.row]
        return cell
    }
}
