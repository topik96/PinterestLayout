//
//  NetworkManager.swift
//  LearningApp
//
//  Created by Topik M on 15/08/22.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private let _baseURL = ""
    
    func retrievePhotos(use url: Constants.BaseURL, completion: @escaping (([Photo]?)-> Void)) {
        
        var urlComp = URLComponents(string:"\(url.string)\(Constants.Endpoint.listPhotos)")!
       
        urlComp.queryItems = [URLQueryItem(name: "page", value: "1" ),
                              URLQueryItem(name: "limit", value: "50")]
       
        var request = URLRequest(url: urlComp.url!)
        request.httpMethod = "Get"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data , error == nil else {
                print("error while fetching feeds \(String(describing: error))")
                completion(nil)
                return
            }
            
            let result = try? JSONDecoder().decode([Photo].self, from: data)
          
            completion(result)
        }
        task.resume()
    }
    
    func retrieveSearchPhotos(url: Constants.BaseURL, query: String, completion: @escaping (([SearchPhoto]?)-> Void)) {
        var urlComp = URLComponents(string:"\(url.string)\(Constants.Endpoint.searchPhotos)")!
       
        urlComp.queryItems = [URLQueryItem(name: "page", value: "1" ),
                              URLQueryItem(name: "query", value: query)]
       
        var request = URLRequest(url: urlComp.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue(Constants.Key.clientID, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data , error == nil else {
                print("error while fetching feeds \(String(describing: error))")
                completion(nil)
                return
            }
            
            let result = try? JSONDecoder().decode(BaseSearchPhoto.self, from: data)
            completion(result?.results)
        }
        task.resume()
    }
}
