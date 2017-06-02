//
//  ParseData.swift
//  Pokedex
//
//  Created by Eric Sans Alvarez on 30/05/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import Foundation

class ParseData {
    
    class func parsePokemonsCSV() -> [PokemonModel] {
        
        var pokemons: [PokemonModel] = []
        
        guard let path = Bundle.main.path(forResource: "pokemon", ofType: "csv") else {
            print("no guard")
            return pokemons
        }
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                if let pokemonId = row["id"], let name = row["identifier"] {
                    let pokemon = PokemonModel(name: name, pokedexId: Int(pokemonId)!)
                    pokemons.append(pokemon)
                }
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        return pokemons
    }
}
