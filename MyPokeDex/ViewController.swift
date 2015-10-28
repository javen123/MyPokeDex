//
//  ViewController.swift
//  MyPokeDex
//
//  Created by Jim Aven on 10/27/15.
//  Copyright © 2015 Jim Aven. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer:AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        
        self.searchBar.returnKeyType = UIReturnKeyType.Done
        
        initAudio()
        parsePokemonCSV()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailSegue" {
            
            if let detailVC = segue.destinationViewController as? DetailVC {
                if let poke = sender as? Pokemon {
                    detailVC.pokemon = poke
                }
            }
        }
    }
    
    func initAudio() {
        
        let  path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
            self.musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            self.musicPlayer.prepareToPlay()
            self.musicPlayer.numberOfLoops = -1
            self.musicPlayer.play()
        } catch  let err as NSError {
            print(err.localizedDescription)
        }
        
    }
    
    @IBAction func btnMusicPressed(sender: UIButton) {
        
        if self.musicPlayer.playing {
            self.musicPlayer.stop()
            sender.alpha = 0.2
        } else {
            self.musicPlayer.play()
            sender.alpha = 1.0
        }
        
        
    }
    
    func parsePokemonCSV() {
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId!)
                self.pokemon.append(poke)
            }
            
        } catch let err as NSError {
            print(err.localizedDescription)
        }
        
    }
    
    //MARK: Collection View funcs
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pokeCell", forIndexPath: indexPath) as? PokeCell {
            
            let poke:Pokemon!
            
            if self.inSearchMode {
                poke = self.filteredPokemon[indexPath.row]
            } else {
                poke = self.pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var poke:Pokemon!
        
        if self.inSearchMode {
            poke = self.filteredPokemon[indexPath.row]
        } else {
            poke = self.pokemon[indexPath.row]
        }
        
        self.performSegueWithIdentifier("detailSegue", sender: poke)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return self.filteredPokemon.count
        }
        
        return self.pokemon.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //MARK: Searchbar funcs
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            self.inSearchMode = false
            self.view.endEditing(true)
            self.collectionView.reloadData()
            
        } else {
            self.inSearchMode = true
            if searchBar.text?.characters.count > 2 {
                let lower = searchBar.text!.lowercaseString
                self.filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
                self.collectionView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

