//
//  photoWork.swift
//  balinaTest
//
//  Created by Egor Tereshonok on 2/17/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                   let imagePicker = UIImagePickerController()
                   imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
                   imagePicker.allowsEditing = false
                   self.present(imagePicker, animated: true, completion: nil)
               }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            NetworkManager.postRequest(id: selectedCell, image: pickedImage)
           }
           picker.dismiss(animated: true, completion: nil)
       }
}
