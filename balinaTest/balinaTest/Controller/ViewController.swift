//
//  ViewController.swift
//  balinaTest
//
//  Created by Egor Tereshonok on 2/17/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var selectedCell = 0
    var fetchingMore = false
    var breakPoint = false
    var page = 0 
    
    var viewModels: [PhotoTypeCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequest()
    }
    
    func getRequest() {
        if !breakPoint {
            fetchingMore = true
            NetworkManager.getRequest(page: page) { (viewModels) in
                
                self.page += 1
                self.fetchingMore = false
                let newData = viewModels
                if newData.count < 1 {
                    print("Ipetoc")
                    self.breakPoint = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.breakPoint = false
                    })
                }
                self.viewModels.append(contentsOf: newData)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
