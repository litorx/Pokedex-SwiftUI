//
//  PokemonService.swift
//  Aula1
//
//  Created by Vitor on 26/08/25.
//

import Foundation


class PokemonService {
    var next: String = ""
    
    
    private let session: URLSession = {
        let c = URLSessionConfiguration.default
        c.timeoutIntervalForRequest = 20
        c.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: c)
    }()
    

    private let decoder = JSONDecoder()

    // 1) Lista plana: /pokemon?limit=10000  -> [PokemonListItem]
    func fetchAllPokemon(limit: Int = 10000) async throws -> [PokemonListItem] {
        guard var url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)") else {
            throw PKDError.invalidURL
        }
        if next != ""{
            url = URL(string: next)!
        }
        let (data, resp) = try await session.data(from: url)
        guard let http = resp as? HTTPURLResponse else { throw PKDError.invalidResponse }
        guard (200...299).contains(http.statusCode) else { throw PKDError.invalidResponse }
        let next = try decoder.decode(PokemonListResponse.self, from: data).next
        self.next = next
        return try decoder.decode(PokemonListResponse.self, from: data).results
        
    }

    // 2) Detalhe: /pokemon/{id|name} -> Pokemon (preenche id, name, forms?, types[], sprites)
    func fetchPokemonDetail(idOrName: String) async throws -> Pokemon {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(idOrName.lowercased())") else {
            throw PKDError.invalidURL
        }
        let (data, resp) = try await session.data(from: url)
        guard let http = resp as? HTTPURLResponse else { throw PKDError.invalidResponse }
        guard (200...299).contains(http.statusCode) else { throw PKDError.invalidResponse }
        return try decoder.decode(Pokemon.self, from: data)
    }
    
}
