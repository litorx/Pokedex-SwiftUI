import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - Models

struct PokemonListResponse: Codable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
}

struct PokemonForm: Codable {
    let name: String
    let url: String
}

struct PokemonSprites: Codable {
    let front_default: String?
    // Se quiser artwork oficial depois:
    // struct Other: Codable { struct OfficialArtwork: Codable { let front_default: String? } let official_artwork: OfficialArtwork }
    // let other: Other?
}

enum PokemonType: String, Codable, CaseIterable {
    case normal, fire, water, grass, electric, ice, fighting, poison, ground, flying
    case psychic, bug, rock, ghost, dragon, dark, steel, fairy
    case unknown
}

struct NamedAPIResource: Codable {
    let name: String
    let url: String
}

struct PokemonTypeSlot: Codable {
    let slot: Int
    let type: NamedAPIResource
}

struct Pokemon: Codable {
    let id: Int
    let name: String
    let forms: [PokemonForm]?
    let sprites: PokemonSprites
    let types: [PokemonTypeSlot]

    /// Tipos já convertidos para o enum, em ordem de slot
    var typeEnums: [PokemonType] {
        types
            .sorted { $0.slot < $1.slot }
            .map { PokemonType(rawValue: $0.type.name) ?? .unknown }
    }
}

// MARK: - Error

enum PKDError: Error, CustomStringConvertible {
    case invalidURL
    case invalidResponse
    case emptyTypes

    var description: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid HTTP response"
        case .emptyTypes: return "Pokemon has no types"
        }
    }
}

// MARK: - Service

class PokemonService {
    private let session: URLSession = {
        let c = URLSessionConfiguration.default
        c.timeoutIntervalForRequest = 20
        c.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: c)
    }()

    private let decoder = JSONDecoder()

    func fetchAllPokemon(limit: Int = 20) async throws -> [PokemonListItem] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)") else {
            throw PKDError.invalidURL
        }
        let (data, resp) = try await session.data(from: url)
        guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw PKDError.invalidResponse
        }
        return try decoder.decode(PokemonListResponse.self, from: data).results
    }

    func fetchPokemonDetail(idOrName: String) async throws -> Pokemon {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(idOrName.lowercased())") else {
            throw PKDError.invalidURL
        }
        let (data, resp) = try await session.data(from: url)
        guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw PKDError.invalidResponse
        }
        return try decoder.decode(Pokemon.self, from: data)
    }

    func fetchForms(for idOrName: String) async throws -> [PokemonForm] {
        let poke = try await fetchPokemonDetail(idOrName: idOrName)
        return poke.forms ?? []
    }
}

// MARK: - Test helpers

func printTypes(_ p: Pokemon) throws {
    let typeNames = p.typeEnums.map { $0.rawValue }
    guard !typeNames.isEmpty else { throw PKDError.emptyTypes }
    print("🔎 \(p.name.capitalized) [#\(p.id)] types:", typeNames.joined(separator: ", "))
}

func expect(_ condition: @autoclosure () -> Bool, _ message: String) {
    if condition() {
        print("✅ \(message)")
    } else {
        print("❌ \(message)")
    }
}

// MARK: - Test Run

let service = PokemonService()

Task {
    do {
        print(" Fetching first 5 Pokémon...")
        let list = try await service.fetchAllPokemon(limit: 5)
        print("   ->", list.map { $0.name }.joined(separator: ", "))

        print("\n Fetching details for pikachu...")
        let pikachu = try await service.fetchPokemonDetail(idOrName: "pikachu")
        try printTypes(pikachu)
        expect(pikachu.typeEnums.contains(.electric), "Pikachu should be Electric")

        print("\n Fetching details for charmander...")
        let charmander = try await service.fetchPokemonDetail(idOrName: "charmander")
        try printTypes(charmander)
        expect(charmander.typeEnums == [.fire], "Charmander should be Fire")

        print("\n Fetching details for bulbasaur...")
        let bulbasaur = try await service.fetchPokemonDetail(idOrName: "bulbasaur")
        try printTypes(bulbasaur)
        expect(bulbasaur.typeEnums == [.grass, .poison], "Bulbasaur should be Grass/Poison")

        print("\n Fetching forms for bulbasaur...")
        let forms = try await service.fetchForms(for: "bulbasaur")
        print("   -> forms:", forms.map { $0.name }.joined(separator: ", "))
        

        let vivillonForms = try await service.fetchForms(for: "vivillon")
        print("   -> visited forms:", vivillonForms.map { $0.name })


        print("\n Done.")
    } catch {
        print(" Error:", (error as? PKDError)?.description ?? String(describing: error))
    }
}
