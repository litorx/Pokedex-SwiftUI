let service = PokemonService()

Task {
    do {
        // Lista (pega alguns só pra não inundar o console)
        let list = try await service.fetchAllPokemon(limit: 30)
        print("Qtd:", list.count)
        print("Primeiro:", list.first?.name ?? "-")

        // Detalhe do primeiro
        if let first = list.first {
            // você já extrai o id pelo url no seu model
            let poke = try await service.fetchPokemonDetail(idOrName: String(first.id))
            print("Detalhe:", poke.id, poke.name)
            print("Tipos:", poke.types.map { $0.type.name.rawValue })
            print("Sprite:",
                  poke.sprites.other.officialArtwork.front_default ?? "nenhum")
        }

        // Forms (ex.: bulbasaur)
        let forms = try await service.fetchForms(for: "bulbasaur")
        print("Forms:", forms.map(\.name))
    } catch {
        print("Erro:", error)
    }
}
