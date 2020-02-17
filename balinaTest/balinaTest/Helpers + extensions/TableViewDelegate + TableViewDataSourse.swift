//
//  TableViewDelegate + TableViewDataSourse.swift
//  balinaTest
//
//  Created by Egor Tereshonok on 2/17/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    //MARK: TAP ON CELL
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath.row - 1
        takePhoto()
        
        
    }
    
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PhotoTypeTableViewCell
        let vm = viewModels[indexPath.row]
        cell.idLabel.text = "id: \(vm.id)"
        cell.nameLabel.text = vm.name
        return cell
    }
}
