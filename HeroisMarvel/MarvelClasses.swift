//
//  MarvelClasses.swift
//  HeroisMarvel
//
//  Created by Vinícius Tinajero Salomão on 30/09/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

struct MarvelInfo: Codable {
    let code: Int
    let status: String
    let data: MarvelData
}

struct MarvelData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Hero]
}

struct Hero: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let urls: [HeroURL]
}

struct Thumbnail: Codable {
    let path: String
    let _extension: String
    
    var url: String {
        return path + "." + _extension
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case _extension = "extension"
    }
}

struct HeroURL: Codable {
    let type: String
    let url: String
}
