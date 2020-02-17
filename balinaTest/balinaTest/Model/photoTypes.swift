//
//  getPhotoModel.swift
//  balinaTest
//
//  Created by Egor Tereshonok on 2/17/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation

struct PhotoTypes: Codable {
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let totalElements: Int
    let content: [Content]
}

// MARK: - Content
struct Content: Codable {
    let id: Int
    let name: String
}
