//
//  Utilities.swift
//  Pokedex
//
//  Created by Eric Sans Alvarez on 30/05/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import Foundation
import SwiftyJSON

class Utilities {
    func loadPokemonAttributes(pokemonAttributes: JSON) -> Pokemon {
        
        var pokemon: Pokemon = Pokemon(name: "", pokedexId: 1)
        
        guard let attack = pokemonAttributes["attack"].int,
            let defense = pokemonAttributes["defense"].int,
            let height = pokemonAttributes["height"].string,
            let weight = pokemonAttributes["weight"].string,
            let types = pokemonAttributes["types"].dictionary,
            let evolutions = pokemonAttributes["evolutions"].dictionary else {
                print("Error")
                return Pokemon(name: "", pokedexId: 1)
        }
        
        var typeConcatenation = ""
        
        for (key,subJson):(String, JSON) in types {
            if let name = subJson["name"].string {
                if typeConcatenation == "" {
                    typeConcatenation = name.capitalized
                } else {
                    typeConcatenation = "\(typeConcatenation)/\(name.capitalized)"
                }
            }g
        }
        
        var currentEvo = ""
        
        for (key,subJson):(String, JSON) in evolutions {
            if let toPokemon = subJson["to"].string {
                if toPokemon != currentEvo {
                    if let level = subJson["level"].int {
                        currentEvo = toPokemon
                    }
                }
            }
        }
        
        //Falta creadora de pokemons a partir de atributos o func para añadir atrib
        return pokemon
    }
    
    func loadPokemonDescription(pokemonDescription: JSON) -> Pokemon {
        //Falta creadore de pokemon a partir de descripcion
    }
}
