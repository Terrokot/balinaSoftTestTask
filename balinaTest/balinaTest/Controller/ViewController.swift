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
    
    var viewModels: [PhotoTypeCellModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getRequest()
    }
    
    func getRequest() {
        guard let url = URL(string: "https://junior.balinasoft.com//api/v2/photo/type") else { return }
        URLSession.shared.dataTask(with: url) {(data, responce, error) in
            guard let responce = responce, let data = data else { return }
            print(responce)
            print(data)
            do {
                let photoTypes = try JSONDecoder().decode(PhotoTypes.self, from: data)
                print(photoTypes)
                self.viewModels = photoTypes.content.compactMap(PhotoTypeCellModel.init)
            } catch {
                print(error)
            }
            
        }.resume()
    }
//URL https://junior.balinasoft.com//api/v2/photo/type

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PhotoTypeTableViewCell
        let vm = viewModels[indexPath.row]
        cell.idLabel.text = "\(vm.id)"
        cell.nameLabel.text = vm.name
        return cell
    }
    
    
}
