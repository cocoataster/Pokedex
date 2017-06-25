//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Eric Sans Alvarez on 02/06/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import Foundation
import Alamofire

class PokemonModel {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _descript: String!
    private var _type: String!
    private var _defense: Int!
    private var _height: String!
    private var _weight: String!
    private var _attack: Int!
    private var _hasEvolution: Bool!
    private var _evoLevel: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var descript: String {
        if _descript == nil {
            _descript = ""
        }
        return _descript
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: Int {
        if _defense == nil {
            _defense = 0
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
    
    var attack: Int {
        if _attack == nil {
            _attack = 0
        }
        return _attack
    }
    
    var hasEvolution: Bool {
        if _hasEvolution == nil {
            _hasEvolution = false
        }
        return _hasEvolution
    }
    
    var evoLevel: Int {
        if _evoLevel == nil {
            _evoLevel = 0
        }
        return _evoLevel
    }
    
    init() {}
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
    init(name: String, pokedexId: Int, descript: String, type: String, defense: Int, height: String, weight: String, attack: Int, hasEvolution: Bool, evoLevel: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._descript = descript
        self._type = type
        self._defense = defense
        self._height = height
        self._weight = weight
        self._attack = attack
        self._hasEvolution = hasEvolution
        self._evoLevel = evoLevel
    }
	
	func addDescription(descript: String) {
		self._descript = descript
	}
    
}
