//
//  ContentsResponse.swift
//  CatBreeds
//
//  Created by yunus oktay on 16.04.2022.
//

import Foundation

// MARK: - ContentsResponse
struct ContentsResponse: Codable {
    let dogFriendly: Int
    let id: String
    let image: Image?
    let lifeSpan: String
    let name: String
    let origin: String
    let description: String
    let temperament: String
    
        enum CodingKeys: String, CodingKey {
        case dogFriendly = "dog_friendly"
        case id, image
        case lifeSpan = "life_span"
        case name
        case origin
        case description
        case temperament
    }
    
}

// MARK: - Image
struct Image: Codable {
    let id: String?
    let url: String?
}


typealias Contents = [ContentsResponse]


