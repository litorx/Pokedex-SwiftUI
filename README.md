# Pokedex-SwiftUI

A Pokédex construída com **SwiftUI** e **MVVM**, consumindo a **PokéAPI**. Permite listar Pokémon, pesquisar por nome/ID, ver detalhes (tipos, nome, podekex, sprites) e paginar resultados — com foco em código limpo e navegabilidade fluida.

> Repo: https://github.com/litorx/Pokedex-SwiftUI

---

## Screenshots

<img width="220" height="450" alt="Captura de Tela 2025-09-22 às 10 07 56" src="https://github.com/user-attachments/assets/74380f74-ad60-4a88-9d0e-1c54cbeb28e0" /> <img width="220" height="450" alt="Captura de Tela 2025-09-22 às 10 08 28" src="https://github.com/user-attachments/assets/324c44ae-88c5-444f-af93-697130a02b80" /><img width="220" height="450" alt="Captura de Tela 2025-09-22 às 10 08 59" src="https://github.com/user-attachments/assets/7b0682e4-052d-43e9-9fa2-62f020225f5b" />

---

##  Features

- Lista de Pokémon com rolagem fluida
- **Busca em tempo real** por **nome** *ou* **ID**
- Tela de detalhes com nome, numero da pokedex, tipos, e sprites (usa *official artwork* ou `front_default` como fallback)
- Estrutura **MVVM** com `URLSession` + `JSONDecoder` (async/await)
- Pronta para **paginação** e **filtros** por tipo (extensível)
- Sem chaves/segredos: API pública

---

##  Stack

- **Swift 5.9+**
- **SwiftUI** (App lifecycle nativo)
- **MVVM**
- **URLSession** + **async/await**
- **Xcode 15+**, iOS **16+** (recomendado)

---

##  Estrutura do projeto

```
Pokedex-SwiftUI/
├── PokedexApp.swift        # Ponto de entrada SwiftUI App
├── Assets.xcassets/        # Imagens e cores do app
├── Components/             # UI reutilizável (cards, chips, barra de busca, etc.)
├── PokemonHome/            # Views de lista / grid e navegação
├── Services/               # Camada de rede e modelos (PokéAPI)
└── Utils/                  # Helpers, extensões e constantes
```
> As pastas acima refletem o repositório atual.

---

##  Como rodar

1. **Clonar o projeto**
   ```bash
   git clone https://github.com/litorx/Pokedex-SwiftUI.git
   cd Pokedex-SwiftUI
   ```

2. **Abrir no Xcode**
   - Tente abrir a pasta diretamente via **File ▸ Open...** no Xcode.
   - Se não houver `.xcodeproj`, crie um **App iOS (SwiftUI)** vazio e **adicione** os arquivos desta pasta ao alvo do app (Target ▸ Build Phases ▸ Compile Sources e Copy Bundle Resources).

3. **Selecionar um simulador** (iPhone 14/15) e **Run** (⌘R).

> Dica: caso use imagens remotas, rode em um simulador com Internet ativa.

---

##  API

- Base: https://pokeapi.co/api/v2/
- Lista paginada: `GET /pokemon?limit=20&offset=0`
- Detalhes por ID/nome: `GET /pokemon/{id|name}`

Sprites utilizados (prioridade):
1) `sprites.other["official-artwork"].front_default`
2) `sprites.front_default` (fallback)


---

##  Arquitetura 

- **Service (Networking)**: `PokemonService` faz `fetchAllPokemon(limit:)` (lista) e `fetchDetails(...)` (detalhes). Usa `URLSession` com `JSONDecoder` e *timeouts* razoáveis.
- **ViewModel**: expõe `@Published pokemons`, `filteredPokemons`, `searchText`, `currentPage/totalPages` e ações como `loadPokemons()` e `pokemonsFilter()`.
- **Views**: listas/grid com `ForEach`, **busca** com `onChange(of: searchText)`, e **detalhes** (card/overlay) usando `ZStack` + `transition` para não cobrir 100% da tela.

> O filtro por ID funciona checando se `searchText` é numérico e comparando com `pokemon.id`. Para nome, usar `localizedCaseInsensitiveContains`.

---


##  Contribuição

Issues e PRs são bem‑vindos. Sugestões de UX/arquitetura e melhorias de performance também!
