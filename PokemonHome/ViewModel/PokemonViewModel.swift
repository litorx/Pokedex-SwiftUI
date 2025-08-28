//
//  TextSearch.swift
//  Aula1
//
//  Created by Vitor on 20/08/25.
import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = [ ]
    
    private let service = PokemonService()
    var currentPage: Int = 1
    var totalPages: Int = 1
    @Published var filteredPokemons: [Pokemon]  = []
    @Published var searchText = ""
    init() {
        
    }

    func loadPokemons() async {
        do {
            let list = try await service.fetchAllPokemon(limit: 20)
            print(service.next)
            var detailed: [Pokemon] = []
            
            for item in list{
                let poke = try await service.fetchPokemonDetail(idOrName: item.name)
                detailed.append(poke)
            }
            self.pokemons.append(contentsOf: detailed)
        } catch {
            print("error")
        }
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
            filteredPokemons = filterPokemons(id, pokemons)
        } else {
            filteredPokemons = filterPokemons(searchText, pokemons)
        }
    }
    
    
    
    func searchText(textSearched: String) -> Int? {
        let foundPokemon = pokemons.first { poke in
            return poke.name.lowercased() == textSearched.lowercased()
        }
        return foundPokemon?.id
    }
    


    func displayName(for pokemon: Pokemon) -> String {
        let base = pretty(pokemon.name)
        let rawForm = pokemon.forms?.first?.name ?? ""

        if rawForm.isEmpty { return base }

        var form = pretty(rawForm)

        if form.caseInsensitiveCompare(base) == .orderedSame { return base }

        if form.lowercased().hasPrefix(base.lowercased()) {
            form = String(form.dropFirst(base.count)).trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return form.isEmpty ? base : "\(base) \(form)"
    }
}

