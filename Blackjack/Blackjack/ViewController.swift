//
//  ViewController.swift
//  BlackJack
//
//  Created by Alex Mathew on 3/2/15.
//  Copyright (c) 2015 Alex Mathew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var NumberOfPlayersText: UITextField!
    @IBOutlet var NumberOfDecks: UITextField!
    
    var players: [User] = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func StartButtonClicked(sender: AnyObject) {
        
        
    }
    
    override func prepareForSegue( segue:UIStoryboardSegue, sender: AnyObject?) {
        
        var DestViewController : GameController = segue.destinationViewController as GameController
        if(NumberOfDecks.text.isEmpty) {
            DestViewController.numberOfDecks = 3 //default
        }
        else {
        DestViewController.numberOfDecks = NumberOfDecks.text.toInt()
        }
        
        if(NumberOfPlayersText.text.isEmpty) {
            DestViewController.numberOfPlayers = 2 //default
        }
        else {
        DestViewController.numberOfPlayers = NumberOfPlayersText.text.toInt()
        }
    }
}

