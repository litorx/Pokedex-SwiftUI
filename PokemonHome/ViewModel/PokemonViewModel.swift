//
//  TextSearch.swift
//  Aula1
//
//  Created by Vitor on 20/08/25.
import Foundation

class PokemonViewModel: ObservableObject {
    let pokemons: [Pokemon] = [
        .init(
            id: 4,
            name: "Charmander",
            forms: nil,
            types:[
                PokemonTypeSlot(slot: 1, type: PokemonTypeInfo(name: .fire))
            ],
            sprites: PokemonSprites(
                front_default: nil,
                other: .init(
                    officialArtwork: .init(
                        front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png", front_shiny: nil
                    )
                )
            )
        ),
        .init(
            id: 196,
            name: "Espeon",
            forms: nil,
            types: [
                PokemonTypeSlot(slot: 1, type: PokemonTypeInfo(name: .psychic))
            ],
            sprites: PokemonSprites(
                front_default: nil,
                other: .init(
                    officialArtwork: .init(
                        front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/196.png", front_shiny: nil
                    )
                )
            )
        ),
        .init(
            id: 12,
            name: "Abc",
            forms: nil,
            types: [
                PokemonTypeSlot(slot: 1, type: PokemonTypeInfo(name: .dragon)),
                PokemonTypeSlot(slot: 2, type: PokemonTypeInfo(name: .electric))
            ],

            sprites: PokemonSprites(
                front_default: nil,
                other: .init(
                    officialArtwork: .init(
                        front_default: "", front_shiny: nil
                    )
                )
            )
        )

    ]

    @Published var filteresPokemons: [Pokemon] = []
    @Published var searchText = ""
    init() {
        
    }
    func spriteURL(for pokemon: Pokemon) -> URL? {
        let raw = pokemon.sprites.other.officialArtwork.front_default
                 ?? pokemon.sprites.front_default

        guard let s = raw, !s.trimmingCharacters(in: .whitespaces).isEmpty else {
            return nil
        }
        return URL(string: s)
    }
    
    private func extractId(_ text: String) -> Int? {
        Int(text.filter { $0.isNumber })
    }
    
    private func isSearchById(_ text: String) -> Bool {
        text.first == "#"
    }
    
    private func filterPokemons(_ id: Int?, _ pokemons: [Pokemon]) -> [Pokemon] {
        guard let id else { return pokemons }
        return pokemons.filter { $0.id == id }
    }
    
    
    private func filterPokemons(_ name: String, _ pokemons: [Pokemon]) -> [Pokemon] {
        guard !name.isEmpty else { return pokemons }
        return pokemons.filter { $0.name.localizedCaseInsensitiveContains(name) }
    }
    
    
    func pokemonsFilter() {
        if isSearchById(searchText) {
            let id = extractId(searchText)
            filteresPokemons = filterPokemons(id, pokemons)
        } else {
            filteresPokemons = filterPokemons( searchText, pokemons)
        }
    }
    
    
    func getPokemons() -> [Pokemon] {
        return []
    }
    
    
    func searchText(textSearched: String) -> Int? {
        let foundPokemon = pokemons.first { poke in
            return poke.name.lowercased() == textSearched.lowercased()
        }
        return foundPokemon?.id
    }
}
