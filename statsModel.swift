//
//  statsModel.swift
//  BasketballBible
//
//  Created by Muji on 2020-10-03.
//  Copyright © 2020 Muji. All rights reserved.
//

/**
 Custom Struct Designed to hold a complete set of statistics for a player
 */
import Foundation

struct PlayerStatModel:Identifiable {
    
    // Unique ID for
    var id: String = UUID().uuidString
    
    // Array for Legend
    var legend:[String]
    
    // PlayerName
    var playerName:String
    
    
    // Full JSON as a Dict
    var fullStatDict:[String:Any]
    
    // Full Stats as a List
    var statAsList:[[String]]
    
    // Full List of Keys
    var keysAsList:[String]
    // Initializer for the model
    init(legend:[String],playerName:String,fullStatDict:[String:Any],statAsList:[[String]],keysAsList:[String]) {
        
        self.legend = legend
        self.playerName = playerName
        self.statAsList = statAsList
        self.fullStatDict = fullStatDict
        self.keysAsList = keysAsList
        
        
    }
    
    
    
    
}

struct GlobalCurrentStatModel {
    var model:PlayerStatModel
}
