//
//  ViewController.swift
//  Pokedex
//
//  Created by Eric Sans Alvarez on 26/05/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        
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
        if let path = Bundle.main.path(forResource: "music", ofType: "mp3") {
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
                musicPlayer.prepareToPlay()
                musicPlayer.numberOfLoops = -1
                musicPlayer.play()
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
    }
    
    func parsePokemonCSV() {
        if let path = Bundle.main.path(forResource: "pokemon", ofType: "csv") {
            do {
                let csv = try CSV(contentsOfURL: path)
                let rows = csv.rows
                
                for row in rows {
                    if let pokeId = row["id"] {
                        if let name = row["identifier"] {
                            let pokemon = Pokemon(name: name, pokedexId: Int(pokeId)!)
                            pokemons.append(pokemon)
                        }
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
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
    
    //MARK - UICollectionView
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon: Pokemon!
            
            if inSearchMode {
                pokemon = Pokemon(name: filteredPokemon[indexPath.row].name, pokedexId: filteredPokemon[indexPath.row].pokedexId)
            } else {
                pokemon = Pokemon(name: pokemons[indexPath.row].name, pokedexId: pokemons[indexPath.row].pokedexId)
            }
            
            cell.configureCell(pokemon)
            
            return cell
        }
        
        else {
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        } else {
            return pokemons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var pokemon: Pokemon!
        
        if inSearchMode {
            pokemon = filteredPokemon[indexPath.row]
        } else {
            pokemon = pokemons[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: pokemon)
        
    }
    
    // MARK - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? DetailVC {
                if let pokemon = sender as? Pokemon {
                    detailsVC.pokemon = pokemon
                }
            }
        }
    }
}

