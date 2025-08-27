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
                VStack(spacing: 12){
                    ForEach(viewModel.filteresPokemons){ row in
                        PokemonCardView(pokemon: row)
                    }
                    
                }
                
            }
            
        }
        .onAppear {
            viewModel.pokemonsFilter()
        }
    }
}
#Preview {
    PokemonHomeView(viewModel: PokemonViewModel())
    
}
