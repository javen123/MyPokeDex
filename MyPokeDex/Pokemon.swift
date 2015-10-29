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
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvoText:String!
    private var _nextEvoId:String!
    private var _nextEvoLvl:String!
    private var _pokemonUrl:String!
    
    var name:String {
        if _name == nil {
            _name = ""
        }
        return self._name
    }
    
    var pokedexId:Int {
        return self._pokedexId
    }
    
    var description:String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type:String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense:String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height:String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight:String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack:String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoText:String {
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    var nextEvoId:String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoLvl:String {
        if _nextEvoLvl == nil {
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
    
    init(name:String, pokedexId:Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
        
    }
    
    func downLoadPokemonDetails(completed:DownloadComplete){
        
        Alamofire.request(.GET, NSURL(string: "\(self._pokemonUrl)")!).responseJSON{(response) -> Void in
            
            if let data = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = data["weight"] as? String {
                    self._weight = weight
                }
                if let height = data["height"] as? String {
                    self._height = height
                }
                if let attack = data["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = data["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = data["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let type = types[0]["name"]{
                        self._type = type.capitalizedString
                    }
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                 self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }
                
                if let evolutions = data["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    if let to = evolutions[0]["to"] as? String {
                        if to.rangeOfString("mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvoId = num
                                self._nextEvoText = to
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvoLvl = "\(lvl)"
                                }
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                if let desc = data["descriptions"] as? [Dictionary<String, String>] where desc.count > 0 {
                    
                    if let url = desc[0]["resource_uri"] {
                        Alamofire.request(.GET, NSURL(string:"\(URL_BASE)\(url)")!).responseJSON{response  in
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                   
                                }
                                completed()
                            }
                        }
                    }
                    
                }else {
                    self._description = ""
                }
                

            }
        }
    }
}
