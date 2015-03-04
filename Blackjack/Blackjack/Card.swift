//
//  Card.swift
//  BlackJack
//
//  Created by Alex Mathew on 3/2/15.
//  Copyright (c) 2015 Alex Mathew. All rights reserved.
//

import Foundation

class Card {
    
    var cardType:String!
    var cardValue:Int!
    
    init(var type:String, var value:Int) {
        
        self.cardType = type
        self.cardValue = value

        
    }
    
}