//
//  ContentView.swift
//  Aula1
//
//  Created by Vitor on 16/08/25.
//

import SwiftUI

struct ContentView: View {
    let viewModel: PokemonViewModel
    
    var body: some View {
        PokemonHomeView(viewModel: viewModel)
    }
}

#Preview {
    ContentView(viewModel: PokemonViewModel())
    
}
