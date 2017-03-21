//
//  RestaulantListTableViewCell.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/21.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaulantListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var walkAccessLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
    
    var restaurant: Restaurant? {
        didSet {
            
            if let urlString = restaurant?.shop_image1 {
                thumbnailView.af_setImage(withURL: URL.init(string: urlString)!)
            }
            
            storeNameLabel.text = restaurant?.name
            
            if let station = restaurant?.station, let walk = restaurant?.walk {
                walkAccessLabel.text = String(format: "%@ %d分", station, walk)
            }
            
            addressLabel.text = restaurant?.address
            
            telLabel.text = restaurant?.tel
            
            budgetLabel.text = restaurant?.budget
        }
    }
}
