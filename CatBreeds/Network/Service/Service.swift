//
//  Service.swift
//  CatBreeds
//
//  Created by yunus oktay on 16.04.2022.
//

import Foundation

struct Service {
    
    func getContents(completion: @escaping (_ contentsResponse: [ContentsResponse]) -> Void) {
        
        let urlString = "https://api.thecatapi.com/v1/breeds"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.addValue("258a7af0-af01-483b-a571-4a6f2e91c25b", forHTTPHeaderField: "x-api-key")

        let urlSession = URLSession.shared
        
        urlSession.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            let decoder = JSONDecoder()
            do {
                let contentsResponse = try! decoder.decode([ContentsResponse].self, from: data!)
                completion(contentsResponse)
            } catch {
                print("Error")
            }
        }.resume()
    }
    
    func getContentsSearch(searchParameter: String, completion: @escaping (_ contentsResponse: [ContentsResponse]) -> Void) {
        
        let urlString = "https://api.thecatapi.com/v1/breeds/search"
        
        guard var urlComponents = URLComponents(string: urlString) else { fatalError() }

        var queryItems = [URLQueryItem]()
        let queryItem = URLQueryItem(name: "q", value: searchParameter)

        queryItems.append(queryItem)

        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        
        request.addValue("258a7af0-af01-483b-a571-4a6f2e91c25b", forHTTPHeaderField: "x-api-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode)
            else {
                return
            }
            if let dataUnwrapped = data {
                do {
                    let contentsResponse = try JSONDecoder().decode([ContentsResponse].self, from: dataUnwrapped)
                    completion(contentsResponse)
                } catch {
                    return
                }
            }
        }.resume()
    }
}

