//
//  Pokeman.swift
//  MyPokeDex
//
//  Created by Jim Aven on 10/27/15.
//  Copyright © 2015 Jim Aven. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name:String!
    private var _podedexId:Int!
    
    var name:String {
        return self._name
    }
    
    var pokedexId:Int {
        return self._podedexId
    }
    
    init(name:String, pokedexId:Int) {
        self._name = name
        self._podedexId = pokedexId
    }
}
