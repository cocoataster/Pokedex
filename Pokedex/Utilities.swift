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
        
        for type in types {
			if let name = type["name"].string {
                if typeConcatenation == "" {
                    typeConcatenation = name.capitalized
                } else {
                    typeConcatenation = "\(typeConcatenation)/\(name.capitalized)"
                }
            }
        }
		
		var hasEvolution = false
		var evoLevel = 0
		
		if (evolutions[0]["to"].string != nil) && (evolutions[0]["level"].int != nil) {
			hasEvolution = true
			evoLevel = evolutions[0]["level"].int!
		}
		
		var urlDescript = ""
		
		if let descriptions = pokemonAttributes["descriptions"][0]["resource_uri"].string {
			urlDescript = descriptions
		}
        
        pokemon = PokemonModel(name: name, pokedexId: pokedexId, descript: urlDescript, type: typeConcatenation, defense: defense, height: height, weight: weight, attack: attack, hasEvolution: hasEvolution, evoLevel: evoLevel)
        
        return pokemon
    }
	
	class func loadPokemonDescription(pokemonDescription: JSON) -> String {
		guard let description = pokemonDescription["description"].string else {
			print("Error, no description")
			return "No description available"
		}
		return description
	}
    
}
