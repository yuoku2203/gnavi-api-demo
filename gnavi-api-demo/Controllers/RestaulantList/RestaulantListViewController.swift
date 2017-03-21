//
//  RestaulantListViewController.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/20.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

final class RestaulantListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let restSearchAPI = RestSearchAPI()
    fileprivate let dataSource = RestaulantListTableView()
    
    fileprivate var restSearchStatus = RestSearchStatus.none
    var area = GArea()
    
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK:- Private
    private func setup() {
        self.title = area.areaname_l
        
        // load data
        restSearchAPI.loadable = self
        if let areaCode = area.areacode_l {
            restSearchAPI.load(areacode_l: areaCode)
        }
        
        // setup tableview
        tableView.estimatedRowHeight = 154
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
}

// MARK:- RestSearchLoadable
extension RestaulantListViewController: RestSearchLoadable {
    func setStatus(status: RestSearchStatus) {
        
        // Update status
        restSearchStatus = status
        
        switch status {
        case .none:
            print("<restSearchStatus: none>")
        case .normal(let result):
            dump(result)
            restSearchAPI.update(total: result.total_hit_count)
            dataSource.add(newRestaurants: result)
            tableView.reloadData()
            
        case .noData:
            print("<restSearchStatus: noData>")
        case .error(let error):
            print("<restSearchStatus: error>\(error.localizedDescription)")
        }
    }
}

//MARK:- UITableViewDelegate
extension RestaulantListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard hasMoreRestaulantList() else { return }
        loadNextRestaulantList()
    }
    
    private func hasMoreRestaulantList() -> Bool {
        
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.bounds.size.height) {
            
            if restSearchAPI.isLoading { return false }
            return restSearchAPI.hasMoreRequest()
        }
        return false
    }
    
    private func loadNextRestaulantList() {
        restSearchAPI.increment()
        restSearchAPI.loadable = self
        if let areaCode = area.areacode_l {
            restSearchAPI.load(areacode_l: areaCode)
        }
    }
}
