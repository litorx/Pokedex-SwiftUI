//
//  Pokemon.swift
//  Aula1
//
//  Created by Vitor on 19/08/25.
//

import Foundation
import SwiftUI

struct Pokemon: Identifiable, Codable, Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let forms: [PokemonForm]?
    let types: [PokemonTypeSlot]
    var sprites: PokemonSprites
}


    
