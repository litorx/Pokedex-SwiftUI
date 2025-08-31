//
//  PokemonSprites.swift
//
//  Created by Vitor on 23/08/25.
//


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
