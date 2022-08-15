//
//  Photo.swift
//  LearningApp
//
//  Created by Topik M on 15/08/22.
//

import Foundation
import UIKit

struct Photo: Codable {
    var id: String?
    var width: Int?
    var height: Int?
    var url: String?
    var downloadUrl: String?
    var desc: String?
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, url, desc
        case downloadUrl = "download_url"
    }
}
