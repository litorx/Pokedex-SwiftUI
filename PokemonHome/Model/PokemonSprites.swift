//
//  PokemonSprites.swift
//  Aula1
//
//  Created by Vitor on 23/08/25.
//

//"sprites": {
//    "official-artwork": {
//        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
//        "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/1.png"
//    }
//},



import Foundation


struct PokemonSprites: Codable {
    struct Other: Codable {
        struct OfficialArtwork: Codable {
            let front_default: String?
            let front_shiny: String?
        }
        let officialArtwork: OfficialArtwork

        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }

    let front_default: String?
    let other: Other
}
