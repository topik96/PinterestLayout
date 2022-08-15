//
//  Constants.swift
//  LearningApp
//
//  Created by Topik M on 15/08/22.
//

import Foundation


struct Constants {
    enum BaseURL {
        case dummy
        case picsum
        case unsplash
        
        var string: String {
            switch self {
            case .dummy:
                return "https://dummyapi.io/data/api"
            case .picsum:
                return "https://picsum.photos"
            case .unsplash:
                return "https://api.unsplash.com"
            }
        }
    }

    struct Endpoint {
        static let listPhotos = "/v2/list"
        static let searchPhotos = "/search/photos"
    }
    
    struct Key {
        static let apiKey = "5fa160451843ad228d0a1c7c"
        static let clientID = "Client-ID d8a272c480b258b875d82f4062d6c52e4ae7f4b4656add778d71e9b638b2f8be"
    }
}
