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
    
    var viewModels: [PhotoTypeCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequest()
    }
    
    func getRequest() {
        NetworkManager.getRequest { (viewModels) in
            self.viewModels = viewModels
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
