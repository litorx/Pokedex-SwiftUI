//
//  ContentView.swift
//  Aula1
//
//  Created by Vitor on 16/08/25.
//

import SwiftUI

struct PokemonHomeView: View {
    @StateObject var viewModel = PokemonViewModel()
    var body: some View {
        VStack{
            NavBarView(viewModel: viewModel)
            ScrollView(.vertical){
                LazyVStack(spacing: 12){
                    ForEach(viewModel.filteredPokemons){ row in
                        PokemonCardView(pokemon: row)
                            .onAppear{
                                if row.id == viewModel.filteredPokemons.count - 5{
                                    
                                    Task{
                                        await viewModel.loadPokemons()
                                    }
                                }
                            }
                    }
                    
                }
                
            }
            
        }
        .task{
            await viewModel.loadPokemons()
        }
    }
}
#Preview {
    PokemonHomeView(viewModel: PokemonViewModel())
    
}
