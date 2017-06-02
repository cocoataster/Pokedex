//
//  DescriptionView.swift
//  Pokedex
//
//  Created by Eric Sans Alvarez on 27/05/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import UIKit
import SwiftyJSON

class DescriptionView: UIViewController {

    var pokemon: PokemonModel!
    
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
        
        let networkManager = NetworkManager()
        networkManager.delegate = self
        networkManager.downloadPokemonAttributes(pokemonId: pokemon.pokedexId)
        
    }
    
    func setUpUI(_ viewModel: DescriptionViewModel) {
        guard let name = viewModel.name,
            let mainImage = viewModel.mainImage,
            let descript = viewModel.descript,
            let type = viewModel.type,
            let defense = viewModel.defense,
            let height = viewModel.height,
            let pokedexId = viewModel.pokedexId,
            let weight = viewModel.weight,
            let attack = viewModel.attack,
            let evoImage = viewModel.evoImage,
            let nextEvolution = viewModel.nextEvolution else {
                print("Something is wrong w/ the view model")
                return
        }
        
        nameLbl.text = name
        mainImg.image = mainImage
        descriptionLbl.text = descript
        typeLbl.text = type
        defenseLbl.text = defense
        heightLb.text = height
        pokedexIDLbl.text = pokedexId
        weightLbl.text = weight
        baseAttackLbl.text = attack
        nextEvoImg.image = evoImage
        evoLbl.text = nextEvolution
        
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// Mark: NetworkManagerDelegate

extension DescriptionView: NetworkManagerDelegate {
    func attributesDownloaded(data: Any?, error: NSError?) {
        if error != nil {
            print("Error: \(error!)")
        }
        
        guard let data = data else {
            print("Error: no data to be displayed")
            return
        }
        
        let json = JSON(data)
        let pokemonModel: PokemonModel = Utilities.loadPokemonAttributes(pokemonAttributes: json)
        pokemon = pokemonModel
        
        let descritpionViewModel = DescriptionViewModel(pokemon)
        setUpUI(descritpionViewModel)
    }
    
    //func description
}
