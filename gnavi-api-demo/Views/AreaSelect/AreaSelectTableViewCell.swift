//
//  AreaSelectTableViewCell.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/20.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

final class AreaSelectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var areaNameLabel: UILabel!
    
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
    
    var area: GArea? {
        didSet {
            areaNameLabel.text = area?.areaname_l
        }
    }
}
