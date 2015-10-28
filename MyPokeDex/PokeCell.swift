//
//  PokeCell.swift
//  MyPokeDex
//
//  Created by Jim Aven on 10/27/15.
//  Copyright © 2015 Jim Aven. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var pokeNameLbl: UILabel!
    
    var pokemon:Pokemon!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    
    func configureCell(pokemon:Pokemon) {
        
        self.pokemon = pokemon
        
        self.pokeNameLbl.text = self.pokemon.name.capitalizedString
        self.pokeImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
