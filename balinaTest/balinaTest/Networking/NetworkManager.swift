//
//  NetworkManager.swift
//  balinaTest
//
//  Created by Egor Tereshonok on 2/18/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    
    
    static func getRequest(page: Int, completion: @escaping (_ viewModels: [PhotoTypeCellModel]) -> ()) {
           guard let url = URL(string: "https://junior.balinasoft.com//api/v2/photo/type?page=\(page)") else { return }
           URLSession.shared.dataTask(with: url) {(data, responce, error) in
               guard let _ = responce, let data = data else { return }
              // print(responce)
              // print(data)
               do {
                   let photoTypes = try JSONDecoder().decode(PhotoTypes.self, from: data)
                   print(photoTypes)
                   let viewModels = photoTypes.content.compactMap(PhotoTypeCellModel.init)
                    completion(viewModels)
               } catch {
                   print(error)
               }
           }.resume()
       }
    
    
    
    static func postRequest(id: Int, image: UIImage) {
        let data = ImageProperties(withImage: image, forKey: "photo")
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = [
            [
                "key": "photo",
                "src": "",
                "type": "file"
            ],
            [
                "key": "name",
                "value": "Egor Tereshonok",
                "type": "text"
            ],
            [
                "key": "typeId",
                "value": "\(id)",
                "type": "text"
            ]] as [[String : Any]]
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        var _: Error? = nil
        for param in parameters {
            if param["disabled"] == nil {
                let paramName = param["key"]!
                body += "--\(boundary)\r\n"
                body += "Content-Disposition:form-data; name=\"\(paramName)\""
                let paramType = param["type"] as! String
                if paramType == "text" {
                    let paramValue = param["value"] as! String
                    body += "\r\n\r\n\(paramValue)\r\n"
                } else {
                    let paramSrc = param["src"] as! String
                    let fileContent = data?.data
                    body += "; filename=\"\(paramSrc)\"\r\n"
                        + "Content-Type: \"content-type header\"\r\n\r\n\(String(describing: fileContent))\r\n"
                }
            }
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://junior.balinasoft.com/api/v2/photo")!,timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=--------------------------568295869406490256468713", forHTTPHeaderField: "Content-Type")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
}
