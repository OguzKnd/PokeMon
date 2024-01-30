//
//  PokemonViewModel.swift
//  PokeMon
//
//  Created by Oğuz Kanda on 17.01.2024.
//

import Foundation

protocol IPokemonViewModel {
    
    func fetchItems ()
    func changeLoading ()
    
    var pokemonCharacters: [PokemonModel] { get set }
    var pokemonService : IPokemonService { get }
    var pokemonOutPut : PokemonOutPut? { get }
    
    func setDelegate(output : PokemonOutPut)

    }

final class PokemonViewModel: IPokemonViewModel {
    var pokemonOutPut: PokemonOutPut?
    
    func setDelegate(output: PokemonOutPut) {
        pokemonOutPut = output
    }
    
        
        var pokemonCharacters: [PokemonModel] = []
        private var isLoading = false;
        var pokemonService: IPokemonService

        init() {
            pokemonService = PokemonService()
        }
    
    func fetchItems() {
        changeLoading()
        pokemonService.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.pokemonCharacters = response ?? []
            self?.pokemonOutPut?.saveDatas(values: self?.pokemonCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        pokemonOutPut?.changeLoading(isload: isLoading)
    }
    
    
}

