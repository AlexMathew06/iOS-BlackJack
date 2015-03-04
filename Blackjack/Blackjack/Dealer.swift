//
//  Dealer.swift
//  BlackJack
//
//  Created by Alex Mathew on 3/2/15.
//  Copyright (c) 2015 Alex Mathew. All rights reserved.
//

import Foundation
class Dealer {
    
    var hand : Hand
    var score:Int
    var busted:Bool = false
    
    init( var h:Hand, var s:Int)
    {
        hand = h; score = s
    }
    
    
    
}