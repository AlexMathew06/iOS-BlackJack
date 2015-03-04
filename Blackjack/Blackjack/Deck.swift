//
//  Deck.swift
//  BlackJack
//
//  Created by Alex Mathew on 3/2/15.
//  Copyright (c) 2015 Alex Mathew. All rights reserved.
//

import Foundation

class Deck {
    
    
    var cards:[Card] = [];
    init() {
        cards.append(Card(type: "Ace",value: 11))
        cards.append(Card(type: "2",value: 2))
        cards.append(Card(type: "3",value: 3))
        cards.append(Card(type: "4", value: 4))
        cards.append(Card(type: "5", value: 5))
        cards.append(Card(type: "6", value: 6))
        cards.append(Card(type: "7", value: 7))
        cards.append(Card(type: "8", value: 8))
        cards.append(Card(type: "9",value: 9))
        cards.append(Card(type: "10", value: 10))
        cards.append(Card(type: "King", value: 10))
        cards.append(Card(type: "Queen", value: 10))
        cards.append(Card(type: "Jack", value: 10))
    }
    
}


