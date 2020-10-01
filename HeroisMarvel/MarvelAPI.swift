//
//  MarvelAPI.swift
//  HeroisMarvel
//
//  Created by Vinícius Tinajero Salomão on 30/09/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation
import SwiftHash
import Alamofire

class MarvelAPI {
    
    static private let basePath = "https://gateway.marvel.com/v1/public/characters?"
    static private let privateKey = "58577ed5f7421ac9bdf83284469e69e145522d20"
    static private let publicKey = "cd5f44fb1372960f355b2ae37fd937f6"
    static private let limit = 50
    
    class func loadHeroes(name: String?, page: Int = 0, onComplete: @escaping (MarvelInfo?) -> Void) {
        let offset = page * limit
        let startsWith: String
        
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))&"
        } else {
            startsWith = ""
        }
        
        let url = basePath + "offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
    
        AF.request(url).responseJSON { (response) in
            guard let data = response.data
            else {
                onComplete(nil)
                return
            }
            guard let marvelInfo = try? JSONDecoder().decode(MarvelInfo.self, from: data)
            else {
                onComplete(nil)
                return
            }
            
            onComplete(marvelInfo)
        }
    }
    
    private class func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts + privateKey + publicKey).lowercased()
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    
}
