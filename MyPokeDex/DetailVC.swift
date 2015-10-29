//
//  DetailVC.swift
//  MyPokeDex
//
//  Created by Jim Aven on 10/28/15.
//  Copyright © 2015 Jim Aven. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var pokemon:Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var curPokeIMg: UIImageView!
    @IBOutlet weak var curPokeDetailLbl: UILabel!
    @IBOutlet weak var curPokeTypeLbl: UILabel!
    @IBOutlet weak var curPokeDefenseLbl: UILabel!
    @IBOutlet weak var curPokeWeightLbl: UILabel!
    @IBOutlet weak var curPokeHeightLbl: UILabel!
    @IBOutlet weak var curPokeId: UILabel!
    @IBOutlet weak var curEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoTextLbl: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokedexId)")
        curPokeIMg.image = img
        curEvoImg.image = img
        
        pokemon.downLoadPokemonDetails { () -> () in
            self.updateUI()
        }
    }
        
    func updateUI(){
        
        curPokeDetailLbl.text = pokemon.description
        curPokeTypeLbl.text = pokemon.type
        curPokeDefenseLbl.text = pokemon.defense
        curPokeHeightLbl.text = pokemon.height
        curPokeWeightLbl.text = pokemon.weight
        curPokeId.text = "\(pokemon.pokedexId)"
        nextEvoImg.image = UIImage(named:pokemon.nextEvoId)
        
        if pokemon.nextEvoId == "" {
            evoTextLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            var str = "Next Evolution:\(pokemon.nextEvoText)"
            
            if pokemon.nextEvoLvl != "" {
                str += " - LVL \(pokemon.nextEvoLvl)"
                self.evoTextLbl.text = str
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBackPressed(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func segmentPressed(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            curPokeDetailLbl.text = pokemon.description
        case 1:
            let abs = pokemon.abilites.joinWithSeparator(",")
            curPokeDetailLbl.text = abs
        default:
            break
        }

    }
}
