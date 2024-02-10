//
//  File.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import Foundation
import SwiftUI
import PokemonAPI

struct PaginatedResultsView: View {
    
    @EnvironmentObject var pokemonAPIEnvironment: PokemonAPIEnvironment
    @State var pageIndex = 0
    
    var body: some View {
        mainContent
            .toolbar {
                ToolbarItemGroup(placement: .principal) {
                    menu
                }
            }
            .task {
                await pokemonAPIEnvironment.fetchPokemon()
            }
    }
    
    var mainContent: some View {
        VStack {
            if let error = pokemonAPIEnvironment.error {
                Text("An error occurred: \(error.localizedDescription)")
            } else if let pagedObject = pokemonAPIEnvironment.pagedObject,
                      let pokemonResults = pagedObject.results as? [PKMNamedAPIResource] {
                List {
                    ForEach(pokemonResults, id: \.url) { pokemon in
                        Text(pokemon.name ?? "Unknown Pokemon")
                    }
                }
                .listStyle(.plain)
            }
        }
    }
    
    var menu: some View {
        HStack {
            Button("First") {
                guard let pagedObject = pokemonAPIEnvironment.pagedObject else { return }
                Task { await pokemonAPIEnvironment.fetchPokemon(paginationState: .continuing(pagedObject, .first)) }
            }
            .disabled(pokemonAPIEnvironment.pagedObject?.hasPrevious == false)
            Spacer()
            
            Button(action: {
                guard let pagedObject = pokemonAPIEnvironment.pagedObject else { return }
                Task { await pokemonAPIEnvironment.fetchPokemon(paginationState: .continuing(pagedObject, .previous)) }
            }) {
                Image.left
            }
            .disabled(pokemonAPIEnvironment.pagedObject?.hasPrevious == false)
            
            Spacer()
            
            pagePicker
                .disabled(pokemonAPIEnvironment.pagedObject?.pages ?? 0 <= 1)
            
            Spacer()
            
            Button(action: {
                guard let pagedObject = pokemonAPIEnvironment.pagedObject else { return }
                Task { await pokemonAPIEnvironment.fetchPokemon(paginationState: .continuing(pagedObject, .next)) }
            }) {
                Image.right
            }
            .disabled(pokemonAPIEnvironment.pagedObject?.hasNext == false)
            
            Spacer()
            
            Button("Last") {
                guard let pagedObject = pokemonAPIEnvironment.pagedObject else { return }
                Task { await pokemonAPIEnvironment.fetchPokemon(paginationState: .continuing(pagedObject, .last)) }
            }
            .disabled(pokemonAPIEnvironment.pagedObject?.hasNext == false)
        }
    }
    
    
    var pagePicker: some View {
        Picker("Pickerz", selection: $pageIndex) {
            if let pagedObject = pokemonAPIEnvironment.pagedObject {
                ForEach(0..<pagedObject.pages, id: \.self) { page in
                    Text("Page \(page + 1)")
                        .tag(page)
                }
            }
        }
        .onChange(of: pageIndex, { _, newIndex in
            guard let pagedObject = pokemonAPIEnvironment.pagedObject else { return }
            Task { await pokemonAPIEnvironment.fetchPokemon(paginationState: .continuing(pagedObject, .page(newIndex))) }
        })
    #if os(macOS)
        .pickerStyle(.menu)
    #endif
    }

}
