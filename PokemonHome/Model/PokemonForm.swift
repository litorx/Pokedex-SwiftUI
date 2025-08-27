//
//  PokemonForm.swift
//  Aula1
//
//  Created by Vitor on 26/08/25.
//

//"forms": [
//    {
//        "name": "bulbasaur",
//        "url": "https://pokeapi.co/api/v2/pokemon-form/1/"
//    }
//],



import Foundation

struct PokemonForm: Codable {
    let name: String
    let url: String
}
