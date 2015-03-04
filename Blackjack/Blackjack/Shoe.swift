//
//  Shoe.swift
//  BlackJack
//
//  Created by Alex Mathew on 3/2/15.
//  Copyright (c) 2015 Alex Mathew. All rights reserved.
//

import Foundation

class Shoe {
    
    
    var currentShoe:[Card] = [Card]()
    
    init(noOfDecks:Int) {
        var decks:[Deck] = [];
        //  var players[User] = [];
        
        
        
        for index in 1...noOfDecks {
            
            decks.append(Deck())
        }
        
        for deck in decks {
            currentShoe.extend(deck.cards)
            }
        

        let count = countElements(self.currentShoe)
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self.currentShoe[i], &self.currentShoe[j])
        }

    }
    
        
        
}