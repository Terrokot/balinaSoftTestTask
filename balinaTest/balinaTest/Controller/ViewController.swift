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
    var myPhoto: UIImage?
    var selectedCell = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        getRequest()
    }
    
    func getRequest() {
        guard let url = URL(string: "https://junior.balinasoft.com//api/v2/photo/type") else { return }
        URLSession.shared.dataTask(with: url) {(data, responce, error) in
            guard let responce = responce, let data = data else { return }
           // print(responce)
           // print(data)
            do {
                let photoTypes = try JSONDecoder().decode(PhotoTypes.self, from: data)
                print(photoTypes)
                self.viewModels = photoTypes.content.compactMap(PhotoTypeCellModel.init)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func postRequest(id: Int, image: UIImage) {
        guard let url = URL(string: "https://api.imgur.com/3/image") else { return }
        guard let imageProperties = ImageProperties(withImage: image, forKey: "image") else { return }
        let httpHeaders = ["Authorization": "Client-ID 48275dec4385a26"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = imageProperties.data
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response, let data = data else { return }
            
           // print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        } .resume()
    }

}



