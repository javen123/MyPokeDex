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
    
    @IBOutlet weak var curPokeHeightLbl: UILabel!
    @IBOutlet weak var curPokeId: UILabel!
    @IBOutlet weak var curEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoTextLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLbl.text = pokemon.name
        self.curPokeIMg.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downLoadPokemonDetails { () -> () in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBackPressed(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    

}
