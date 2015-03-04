//
//  User.swift
//  BlackJack
//
//  Created by Alex Mathew on 3/2/15.
//  Copyright (c) 2015 Alex Mathew. All rights reserved.
//

import Foundation

class User {
    
    
    var hand : Hand
    var balance:Int
    var score:Int
    var playerNumber:Int
    var busted:Bool = false
    var betAmount:Int = 20 // DEFAULT

    
    init( var h:Hand, var b:Int, var s:Int, var pn:Int)
    {
        hand = h; balance = b; score = s; playerNumber = pn;
    }
    
    func noBalance()->Bool {
        if(balance <= 0)
        {
            return true
        }
        else {
            return false
        }
    }
    
    
}