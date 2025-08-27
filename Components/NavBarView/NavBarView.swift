//
//  NavBar.swift
//  Aula1
//
//  Created by Vitor on 19/08/25.
//

import SwiftUI

struct NavBarView: View {
    let constant =  NavBarConstants()
    @StateObject var viewModel: PokemonViewModel

    var body: some View {
    
        contentBar()
            .padding(.vertical, constant.sm)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: constant.md)
                    .fill(Color(.white))
            )
            .overlay(
                RoundedRectangle(cornerRadius: constant.md)
                    .stroke(Color(.black).opacity(constant.vs), lineWidth: constant.on)
            )
            .shadow(color: Color.black.opacity(constant.ns), radius: constant.fr, x: constant.on, y: constant.fr)
            .frame(maxWidth: constant.b1, minHeight: constant.b2)
            .padding(.horizontal, constant.sm)
    }

    @ViewBuilder
    private func contentBar() -> some View{
        HStack(spacing: constant.md) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .imageScale(.medium)
                .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            TextField("Search...", text: $viewModel.searchText)
                .textFieldStyle(.plain)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .searchable(text: $viewModel.searchText)
                .onChange(of: viewModel.searchText) { oldValue, newValue in
                    viewModel.pokemonsFilter()
                }
            
        }
    }
}

#Preview {
    PokemonHomeView()
}
