//
//  PokemonCellView.swift
//  Pokedex
//
//  Created by Eric Sans Alvarez on 26/05/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class PokemonCellView: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: PokemonModel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: PokemonModel) {
        
        self.pokemon = pokemon
        
        self.thumbImg.image = UIImage(named: "\(pokemon.pokedexId)")
        self.nameLbl.text = pokemon.name.capitalized
    }
    
}
