import SwiftUI

// MARK: - Card simples
struct PokemonCardView: View {
    let constants = PokemonCardConstants()
    @State var pokemon: Pokemon
    @StateObject var viewModel = PokemonViewModel()
    var situational: Bool = false
    
    
    var body: some View {
//        if viewModel.filteresPokemons.isEmpty{
//            situationalCard()
//        }
        let base = (pokemon.types.first?.type.name ?? .normal).color
        
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: constants.vs) {
                pokeHeeader()
                pokeType()
            }
            Pokeimage()
            
        }
        .padding(.leading, constants.lp)
        .padding(constants.pd)
        
        .background(
            RoundedRectangle(cornerRadius: constants.cr)
                .fill(base.opacity(0.25))
            
        )
        .overlay(
            RoundedRectangle(cornerRadius: constants.cr)
                .stroke(base.opacity(0.25), lineWidth: constants.lw)
        )
        .padding(.horizontal, constants.hp)
    }

    @ViewBuilder
    public func situationalCard() -> some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass.circle")
                .font(.system(size: 56, weight: .regular))
                .opacity(0.3)

            Text("Nenhum Pokémon aqui")
                .font(.title3.weight(.semibold))

            Text("Tente ajustar a busca ou limpar os filtros.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(constants.hs)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: constants.cr)
                .fill(Color.gray.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: constants.cr)
                .stroke(Color.gray.opacity(0.2), lineWidth: constants.lw)
        )
        .padding(.horizontal, constants.hp)
    }
    
    @ViewBuilder
    private func Pokeimage() -> some View {
        ZStack {
             Circle()
                 .fill(.white.opacity(constants.op))
                 .frame(width: constants.cs, height: constants.cs)

             if let url = viewModel.spriteURL(for: pokemon) {
                 AsyncImage(url: url) { image in
                     image.resizable()
                 } placeholder: {
                     ProgressView()
                 }
                 .scaledToFit()
                 .frame(width: constants.im, height: constants.im)
                 .clipShape(Circle())
             }
         }
    }

    @ViewBuilder
    private func pokeHeeader() -> some View {
        HStack(spacing: constants.hs) {
            Text(String(format: "#%04d", pokemon.id))
                .font(.subheadline.monospacedDigit())
                .foregroundStyle(.secondary)
                .padding(.horizontal, constants.tx)

            Text(viewModel.displayName(for: pokemon))
                .font(.title3.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

        }
    }
    @ViewBuilder
    private func pokeType() -> some View {
        HStack(spacing: constants.ht) {
            ForEach(pokemon.types.sorted { $0.slot < $1.slot }) { slot in
                let t = slot.type.name //
                Text(t.rawValue.uppercased())
                    .textBorder(color: .black, linewidth: 3)
                    .font(.system(size: constants.fs))
                    .fontWeight(.heavy)
                    .tracking(constants.tr)
                    .padding(.horizontal, constants.th)
                    .padding(.vertical, constants.tv)
                    .background(t.color.opacity(0.25))
                    .foregroundStyle(t.color)
                    .clipShape(Capsule())
                    
            }

            .padding(.top, constants.tp)
        }
    }
    
}
#Preview{
    PokemonHomeView()
}
