//
//  Pokeman.swift
//  MyPokeDex
//
//  Created by Jim Aven on 10/27/15.
//  Copyright © 2015 Jim Aven. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name:String!
    private var _pokedexId:Int!
    private var _description:String!
    private var _type:String!
    private var _defensee:String!
    private var _height:String!
    private var _weight:String!
    private var _attach:Int!
    private var _nextEvoText:String!
    private var _pokemonUrl:String!
    
    
    var name:String {
        return self._name
    }
    
    var pokedexId:Int {
        return self._pokedexId
    }
    
    init(name:String, pokedexId:Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
        
    }
    
    func downLoadPokemonDetails(completed:DownloadComplete){
        
        Alamofire.request(.GET, NSURL(string: "\(self._pokemonUrl)")!).response { (request:NSURLRequest?, response:NSHTTPURLResponse?, result:NSData?, err:NSError?) -> Void in
            
            print(result?.debugDescription)
            
        }
        
        
    }
}
