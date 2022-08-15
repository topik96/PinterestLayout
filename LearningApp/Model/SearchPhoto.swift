//
//  SearchPhoto.swift
//  LearningApp
//
//  Created by Topik M on 15/08/22.
//

import Foundation
import UIKit

struct BaseSearchPhoto: Codable {
    var total: Int?
    var totalPages: Int?
    var results: [SearchPhoto]?
    
    enum CodingKeys: String, CodingKey {
        case results, total
        case totalPages = "total_pages"
    }
}

struct SearchPhoto: Codable {
    var id: String?
    var width: Int?
    var height: Int?
    var urls: URLs?
    var desc: String?
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, urls
        case desc = "description"
    }
}

struct URLs: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
}
