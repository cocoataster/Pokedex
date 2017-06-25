//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Eric Sans Alvarez on 30/05/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManagerDelegate {
    func attributesDownloaded(data: Any?, error: NSError?)
    func descriptionDownloaded(data: Any?, error: NSError?)
}

class NetworkManager: NSObject {
    let webURL: String = "http://pokeapi.co"
    let pokemonURL: String = "http://pokeapi.co/api/v1/pokemon/"
    var delegate: NetworkManagerDelegate?
    
    
    func downloadPokemonAttributes(pokemonId: Int) {
        
        let attributesURL = pokemonURL.appending("\(pokemonId)")
        
        Alamofire.request(attributesURL).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let json = response.result.value else {
                    return
                }
                self.delegate?.attributesDownloaded(data: json, error: nil)
            case .failure(let error):
                self.delegate?.attributesDownloaded(data: nil, error: error as NSError)
            }
        }
    }
    
    func downloadPokemonDescription(url: String) {
        
        let descriptionURL = webURL.appending(url)
		
        Alamofire.request(descriptionURL).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let json = response.result.value else {
                    return
                }
                self.delegate?.descriptionDownloaded(data: json, error: nil)
            case .failure(let error):
                self.delegate?.descriptionDownloaded(data: nil, error: error as NSError)
            }
        }
    }
}
