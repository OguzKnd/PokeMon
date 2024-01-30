//
//  PokemonService.swift
//  PokeMon
//
//  Created by Oğuz Kanda on 17.01.2024.
//

import Foundation

protocol IPokemonService {
    
    func fetchAllDatas(response: @escaping ([PokemonModel]?) -> Void)
}

struct PokemonService:IPokemonService {
    
    func fetchAllDatas(response: @escaping ([PokemonModel]?) -> Void) {
        
        
        var pokemonList = [PokemonModel]()
        let dispatchGroup = DispatchGroup()
        
        for index in 1...1000 {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(index)") else {
                print("Invalid URL")
                response(nil)
                return
            }
            
            dispatchGroup.enter()
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                defer { dispatchGroup.leave() }
                
                guard let data = data, error == nil else {
                    print("Something went wrong: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                do {
                    let pokemon = try JSONDecoder().decode(PokemonModel.self, from: data)
                    pokemonList.append(pokemon)
                } catch {
                    print("Failed to decode data: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            response(pokemonList)
        }
        
    }
    
}
