//
//  PokemonList.swift
//  Aula1
//
//  Created by Vitor on 26/08/25.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable, Identifiable {
    let name: String
    let url: String

    var id: Int {
        Int(url.split(separator: "/").last { !$0.isEmpty } ?? "0") ?? 0
    }
}
