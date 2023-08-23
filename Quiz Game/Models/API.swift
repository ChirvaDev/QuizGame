//
//  API.swift
//  Quiz Game
//
//  Created by Pro on 03.08.2023.
//

import Foundation

class Api {
    func getData(completion: @escaping ([DataModel]?, Error?) -> ()) {
        guard let url = URL(string: "https://jservice.io/api/random") else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "Data not received", code: -1, userInfo: nil))
                return
            }
            
            do {
                let dataModel = try JSONDecoder().decode([DataModel].self, from: data)
                completion(dataModel, nil)
            } catch {
                completion(nil, error)
            }
        }
        .resume()
    }
}


