//
//  Pokemon.swift
//  Pokedex
//
//  Created by Eric Sans Alvarez on 26/05/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    private var _pokemonURL: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(pokedexId)/"
    }
    
    func downloadPokemonDetail(completed: DownloadCompleted) {
        
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                if let attack = json["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = json["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let height = json["height"] as? String {
                    self._height = height
                }
                if let weight = json["weight"] as? Int {
                    self._weight = "\(weight)"
                }
                if let types = json["type"] as? [Dictionary<String, String>] {
                    var typeConcatenation = ""
                    for type in types {
                        typeConcatenation = "\(typeConcatenation)\(type)"
                    }
                }
            }
            
        }
    }
    
}
