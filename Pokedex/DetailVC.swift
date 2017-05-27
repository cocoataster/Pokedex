//
//  DetailVC.swift
//  Pokedex
//
//  Created by Eric Sans Alvarez on 27/05/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLb: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalized
        
        let image = UIImage(named: "\(pokemon.pokedexId)")
        
        mainImg.image = image
        
        pokemon.downloadPokemonDetail {
            //After network call is completed
            self.updateUI()
        }
        
    }
    
    func updateUI() {
        pokedexIDLbl.text = "\(pokemon.pokedexId)"
        baseAttackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        weightLbl.text = pokemon.weight
        heightLb.text = pokemon.height
        typeLbl.text = pokemon.type
        
        descriptionLbl.text = pokemon.descript
        
        if pokemon.nextEvolutionTxt != "" {
            evoLbl.text = pokemon.nextEvolutionTxt
            nextEvoImg.image = UIImage(named: "\(pokemon.pokedexId+1)".capitalized)
        } else {
            evoLbl.text = "No evolution available (by lvl)"
            nextEvoImg.image = UIImage()
        }
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
