//
//  Hand.swift
//  BlackJack
//
//  Created by Alex Mathew on 3/2/15.
//  Copyright (c) 2015 Alex Mathew. All rights reserved.
//

import Foundation

class Hand {
    
    var cards:[Card] = [];
    
    //return score
    func getscore()->Int
    {
        handleAces()
        return calculateScore()
    }
    
    //calculate score of current hand
    func calculateScore() -> Int{
        var score = 0
        for card in cards {
            score += card.cardValue
            
        }
        return score
    }
    
    //chooses 1 or 11 for aces
    func handleAces()
    {
        for card in cards {
            if(calculateScore() > 21) {
                if(card.cardValue == 11) {
                    card.cardValue = 1 }
            }
            else {
                break
            }
        }
    }
    
    func showHand()->String{
        var hand = ""
        handleAces()
        for card in cards {
            hand += card.cardType + "  "
        }
        return hand
    }

}