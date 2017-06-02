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
    class func loadPokemonAttributes(pokemonAttributes: JSON) -> PokemonModel {
        
        var pokemon = PokemonModel()
        
        guard let name = pokemonAttributes["name"].string,
            let pokedexId = pokemonAttributes["pkdx_id"].int,
            let attack = pokemonAttributes["attack"].int,
            let defense = pokemonAttributes["defense"].int,
            let height = pokemonAttributes["height"].string,
            let weight = pokemonAttributes["weight"].string,
            let types = pokemonAttributes["types"].array,
            let evolutions = pokemonAttributes["evolutions"].array else {
                print("Error")
                return PokemonModel()
        }
        
        var typeConcatenation = ""
        
//        for type in types {
//            if let name = type["name"].string {
//                if typeConcatenation == "" {
//                    typeConcatenation = name.capitalized
//                } else {
//                    typeConcatenation = "\(typeConcatenation)/\(name.capitalized)"
//                }
//            }
//        }
        
        var currentEvo = ""
        
//        if let evolution = evolutions[0]["to"].string {
//            if let level = evolutions[0]["level"].int {
//                currentEvo = "Next evolution: \(evolution) at Lvl \(level)"
//            } else {
//                currentEvo = "No evolution available by Lvl"
//            }
//        }
        
        //loadPokemonDescription by calling Network manager!
        // mock data
        
        let descript = "Hey! Here you have a mock descrtiption. Have fun... coding is funny right? right???? run now that you can!"
        
        pokemon = PokemonModel(name: name, pokedexId: pokedexId, descript: descript, type: typeConcatenation, defense: defense, height: height, weight: weight, attack: attack, hasEvolution: false, evoLevel: 0)
        
        return pokemon
    }
    
//    func loadPokemonDescription(pokemonDescription: JSON) -> String {
//        //Falta creadore de pokemon a partir de descripcion
//    }
    
}
