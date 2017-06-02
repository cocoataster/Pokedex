
//
//  ViewController.swift
//  Pokedex
//
//  Created by Eric Sans Alvarez on 26/05/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var soundBtn: UIButton!
    
    var pokemons = [PokemonModel]()
    var filteredPokemon = [PokemonModel]()
    var inSearchMode = false
    var segueId = "PokemonDetailVC"
    
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        //Want no music bro...
        soundBtn.isHidden = true
        
        pokemons = ParseData.parsePokemonsCSV()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //audioBackground()
        
    }
    
    @IBAction func musicBtn(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.3
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func audioBackground() {
        guard let path = Bundle.main.path(forResource: "music", ofType: "mp3") else {
            return
        }
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    //MARK - UISearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collection.reloadData()
            
        } else {
            inSearchMode = true
            
            filteredPokemon = pokemons.filter({$0.name.localizedStandardRange(of: searchBar.text!) != nil})
            collection.reloadData()
            
//            Is the same as...
//            filteredPokemon = pokemons.filter({ (pokemon) -> Bool in
//                return pokemon.name.localizedStandardRange(of: searchBar.text!) != nil
//            })
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // MARK - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            if let detailsVC = segue.destination as? DetailVC {
                if let pokemon = sender as? PokemonModel {
                    detailsVC.pokemon = pokemon
                }
            }
        }
    }
}

// Mark: UICollectionView Delegate, Data Source & Flow Layout

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell else {
            return UICollectionViewCell()
        }
        
        let pokemon: PokemonModel = inSearchMode ? PokemonModel(name: filteredPokemon[indexPath.row].name, pokedexId: filteredPokemon[indexPath.row].pokedexId) : PokemonModel(name: pokemons[indexPath.row].name, pokedexId: pokemons[indexPath.row].pokedexId)
        
        cell.configureCell(pokemon)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return inSearchMode ? filteredPokemon.count : pokemons.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pokemon: PokemonModel = inSearchMode ? filteredPokemon[indexPath.row] : pokemons[indexPath.row]
        self.performSegue(withIdentifier: segueId, sender: pokemon)
    }
}
