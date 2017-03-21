//
//  AreaSelectViewController.swift
//  gnavi-api-demo
//
//  Created by OkuderaYuki on 2017/03/20.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit

final class AreaSelectViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let gAreaLargeSearchAPI = GAreaLargeSearchAPI()
    fileprivate let dataSource = AreaSelectTableView()
    
    fileprivate var gAreaLargeSearchStatus = GAreaLargeSearchStatus.none
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK:- Private
    private func setup() {
        self.title = NSLocalizedString("AreaSelectViewControllerTitle", comment: "NavigationBarTitle")
        
        // fetch data
        gAreaLargeSearchAPI.loadable = self
        gAreaLargeSearchAPI.fetch()
        
        // setup tableview
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
}

// MARK:- GAreaLargeSearchLoadable
extension AreaSelectViewController: GAreaLargeSearchLoadable {
    func setStatus(status: GAreaLargeSearchStatus) {
        
        // Update status
        gAreaLargeSearchStatus = status
        
        switch status {
        case .none:
            print("<gAreaLargeSearchStatus: none>")
        case .normal(let result):
            
            print("<gAreaLargeSearchStatus: normal>東京都: \(result.garea_large.count)件")
            result.garea_large.enumerated().forEach {
                if let areacode_l = $0.element.areacode_l, let areaname_l = $0.element.areaname_l {
                    print("[\($0.offset)]areacode_l: \(areacode_l), areaname_l: \(areaname_l)")
                }
            }
            
            dataSource.add(newAreas: result)
            tableView.reloadData()
            
        case .noData:
            print("<gAreaLargeSearchStatus: noData>")
        case .error(let error):
            print("<gAreaLargeSearchStatus: error>\(error.localizedDescription)")
        }
    }
}

// MARK:- UITableViewDelegate
extension AreaSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "RestaulantListViewController", bundle: nil).instantiateInitialViewController() as! RestaulantListViewController
        vc.area = dataSource.areas.garea_large[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
