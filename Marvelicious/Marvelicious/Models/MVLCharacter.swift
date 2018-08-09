//
//  MVLCharacter.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

struct MVLCharacter: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: MVLThumbnail?
    var comics: MVLComicsList?
}

struct MVLThumbnail: Codable {
    var path: String?
    var fileType: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileType = "extension"
    }
}

struct MVLComicsList: Codable {
    var available: Int?
    var items: [MVLComic]?
}

struct MVLComic: Codable {
    var name: String?
}
