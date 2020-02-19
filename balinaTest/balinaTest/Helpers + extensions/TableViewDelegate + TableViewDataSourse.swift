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
    //MARK: SCROLL

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let offSetY = scrollView.contentOffset.y
          let contentHeight = scrollView.contentSize.height
          
          if offSetY > contentHeight - scrollView.frame.height {
              if !fetchingMore {
                  getRequest()
                  print("fetch more data")
              }
          }
      }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return viewModels.count
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PhotoTypeTableViewCell
        let vm = viewModels[indexPath.row]
        cell.idLabel.text = "id: \(vm.id)"
        cell.nameLabel.text = vm.name
        return cell
    }
}
