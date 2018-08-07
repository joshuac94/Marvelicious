//
//  MVLCharacterList.swift
//  Marvelicious
//
//  Created by Joshua Colley on 07/08/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation

struct MVLData: Codable {
    var data: MVLResults?
}


struct MVLResults: Codable {
    var list: [MVLCharacter]?
}
