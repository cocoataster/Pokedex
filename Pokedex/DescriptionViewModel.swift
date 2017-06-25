//
//  DescriptionViewModel.swift
//  Pokedex
//
//  Created by Eric Sans Alvarez on 02/06/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import Foundation
import UIKit

class DescriptionViewModel {
    var pokemonData: PokemonModel
    
    var name: String?
    var mainImage: UIImage?
    var descript: String?
    var type: String?
    var defense: String?
    var height: String?
    var pokedexId: String?
    var weight: String?
    var attack: String?
    
    var hasEvolution: Bool?
    var evoImage: UIImage?
    var evoLevel: String?
    var nextEvolution: String?
    
    init(_ pokemonModel: PokemonModel) {
        self.pokemonData = pokemonModel
        
        self.name = pokemonModel.name
        self.mainImage = UIImage(named: "\(pokemonModel.pokedexId)".capitalized)
        self.descript = pokemonModel.descript
        self.type = pokemonModel.type
        self.defense = String(pokemonModel.defense)
        self.height = pokemonModel.height
        self.pokedexId = String(pokemonModel.pokedexId)
        self.weight = pokemonModel.weight
        self.attack = String(pokemonModel.attack)
        
        self.hasEvolution = pokemonModel.hasEvolution
        self.evoImage = pokemonModel.hasEvolution ? UIImage(named: "\(pokemonModel.pokedexId+1)".capitalized) : UIImage()
        self.evoLevel = String(pokemonModel.evoLevel)
        self.nextEvolution = pokemonModel.hasEvolution ? "Next evolution @ Lvl \(pokemonModel.evoLevel)" : "No evolution available by Lvl"

    }
    
}
