//
//  PhotoTypeCellModel.swift
//  balinaTest
//
//  Created by Egor Tereshonok on 2/17/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation

struct PhotoTypeCellModel {
      let id: Int
      let name: String
}

extension PhotoTypeCellModel {
    init?(content: Content) {
        self.id = content.id
        self.name = content.name
    }
}
