//
//  GameController.swift
//  BlackJack
//
//  Created by Alex Mathew on 3/2/15.
//  Copyright (c) 2015 Alex Mathew. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    var numberOfPlayers:Int!
    var numberOfDecks:Int!
    var shoe: [Card] = [Card]()
    var players: [User] = [User]()
    var dealer:Dealer!
    var currentPlayerNumber:Int = 0
    var winnerList:String = ""
    var tieList:String = ""
    var playerSetBetNumber:Int = 0
    var betPlayerNumber:Int = 0
    
    @IBOutlet var nextGameButton: UIButton!
    
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var hitButton: UIButton!
    @IBOutlet var standButton: UIButton!
    ///UI elements
    @IBOutlet var dealerScoreLabel: UILabel!
    @IBOutlet var dealerHandLabel: UILabel!
    @IBOutlet var betText: UITextField!
    @IBOutlet var playerScoreLabel: UILabel!
    @IBOutlet var playerHandLabel: UILabel!
    @IBOutlet var playerBalanceLabel: UILabel!
    @IBOutlet var playerIdentifierLabel: UILabel!
    
    @IBOutlet var newGameButton: UIButton!
    @IBOutlet var enterBetLabel: UILabel!
    @IBOutlet var enterBetAmountLabel: UIImageView!
    @IBOutlet var betButton: UIButton!
    @IBOutlet var enterBetText: UIImageView!
    @IBOutlet var enterBetTextField: UITextField!
    @IBOutlet var enterBetPlayerLabel: UILabel!
    @IBOutlet var MainBackgroundImage: UIImageView!
    
    
    @IBOutlet var betBackgroundImage: UIImageView!
    ///UI elements
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoe.extend(Shoe(noOfDecks: self.numberOfDecks).currentShoe)
        if(players.isEmpty){
        for playerNumber in 0...numberOfPlayers-1 {
            players.append(User(h: Hand(), b: 100, s: 0, pn: playerNumber))
        }
        }
        else
        {
            for playerNumber in 0...numberOfPlayers-1 {
                players[playerNumber].score = 0
                players[playerNumber].busted = false
                players[playerNumber].hand = Hand()
            }
        }
        dealer = Dealer(h: Hand(), s: 0)
        resetButton.hidden = true
        nextGameButton.hidden = true
        enterBetPlayerLabel.text = "Player 1(max bet: \(players[0].balance/2))"
        
    }
    @IBAction func enterBetClicked(sender: AnyObject) {
        if(!enterBetTextField.text.isEmpty && enterBetTextField.text.toInt() <= (players[betPlayerNumber].balance)/2)
        {
        if(betPlayerNumber >= numberOfPlayers - 1)
        {
            players[betPlayerNumber].betAmount = enterBetTextField.text.toInt()!
            players[betPlayerNumber].balance = players[betPlayerNumber].balance - players[betPlayerNumber].betAmount
            betPlayerNumber = betPlayerNumber + 1
            enterBetPlayerLabel.text = "Player \(betPlayerNumber+1)"

            betButton.hidden = true
            enterBetText.hidden = true
            enterBetLabel.hidden = true
            enterBetAmountLabel.hidden = true
            enterBetTextField.hidden = true
            enterBetPlayerLabel.hidden = true
            betBackgroundImage.hidden = true
            MainBackgroundImage.hidden = false
            initialSteup()
            loadPlayerEnvironment(0) // 1st player
        }
        else
        {
            players[betPlayerNumber].betAmount = enterBetTextField.text.toInt()!
            players[betPlayerNumber].balance = players[betPlayerNumber].balance - players[betPlayerNumber].betAmount
            betPlayerNumber = betPlayerNumber + 1
            enterBetPlayerLabel.text = "Player \(betPlayerNumber+1)(max bet: \(players[betPlayerNumber].balance/2))"
            enterBetTextField.text = ""
            
        }
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //initialSteup()
        //loadPlayerEnvironment(0) // 1st player
    }
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func setBet(alert: UIAlertAction!){
        // store the new word
        if self.betText.text.isEmpty {
            players[playerSetBetNumber].betAmount = 0
        }
        else{
            players[playerSetBetNumber].betAmount = self.betText.text.toInt()!
        }
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
    func addTextField(textField: UITextField!){
        // add the text field and make the result global
        textField.placeholder = "Bet Amount will be zero, if empty"
        self.betText = textField
    }

    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    func initialSteup()
    {
        dealerPlay()
        for playerNumber in 0...numberOfPlayers-1 {
        playerPlay(playerNumber)
          playerPlay(playerNumber)
        }
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func dealerPlay() {
        if(!dealer.busted){
            dealer.hand.cards.append(shoe[0])
            dealerHandLabel.text = dealer.hand.showHand()
            shoe.removeAtIndex(0)
            dealer.score = dealer.hand.getscore()
            dealerScoreLabel.text = "\(dealer.score)  "
            if(dealer.score > 21){
                dealer.busted = true
                dealerBusted()
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func lastDealerPlay() {
        var allBusted:Bool = true
        var atleastOneWine:Bool = false
        var atleastOneTie:Bool = false
        var haveBalance:Bool = false
      
        var playerNumberMax:Int = 0
        for playerNumber in 0...numberOfPlayers-1 {
            
            allBusted = allBusted && players[playerNumber].busted
        }
        if(allBusted)
        {
            var placeBetAlert = UIAlertController(title: "Dealer wins" ,message: "All \(numberOfPlayers) Players Busted !",preferredStyle:UIAlertControllerStyle.Alert)
            placeBetAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(placeBetAlert, animated: true, completion: nil)
            
            for playerNumber in 0...numberOfPlayers-1 {
                if(!players[playerNumber].noBalance()) {
                    haveBalance = true
                }
            }
            if(!haveBalance) {
                nextGameButton.hidden = true
            }
            
        }
        else
        {
            while(dealer.score<16)
            {
                    dealerPlay()
            }
            
            
            for playerNumber in 0...numberOfPlayers-1 {
                if(!players[playerNumber].busted && dealer.score < players[playerNumber].score) {
                    winnerList = winnerList +  " \(playerNumber+1)"
                    players[playerNumber].balance = players[playerNumber].balance + 2 * players[playerNumber].betAmount
                    atleastOneWine = true
                }
                else if(!players[playerNumber].busted && dealer.score == players[playerNumber].score) {
                    tieList = tieList + " \(playerNumber+1)"
                      players[playerNumber].balance = players[playerNumber].balance + players[playerNumber].betAmount
                    atleastOneTie = true
                }
                else if(!players[playerNumber].busted && dealer.score > players[playerNumber].score)
                {
                    //players[playerNumber].balance = players[playerNumber].balance - players[playerNumber].betAmount

                }
            }
            if(!atleastOneTie && !atleastOneWine) {
                var placeBetAlert = UIAlertController(title: "Game Over" ,message: "Dealer beats all players !!",preferredStyle:UIAlertControllerStyle.Alert)
                placeBetAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(placeBetAlert, animated: true, completion: nil)
                haveBalance = true
                for playerNumber in 0...numberOfPlayers-1 {
                    if(!players[playerNumber].noBalance()) {
                        haveBalance = true
                    }
                }
                if(!haveBalance) {
                    nextGameButton.hidden = true
                }

                
            }
            
            else if (atleastOneWine && atleastOneTie) {
                var placeBetAlert = UIAlertController(title: "Game Over" ,message: "Players: \(winnerList) win and players: \(tieList) tie with he dealer!!",preferredStyle:UIAlertControllerStyle.Alert)
                placeBetAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(placeBetAlert, animated: true, completion: nil)
            }
            else if (atleastOneWine) {
                var placeBetAlert = UIAlertController(title: "Game Over" ,message: "Players: \(winnerList) win !!",preferredStyle:UIAlertControllerStyle.Alert)
                placeBetAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(placeBetAlert, animated: true, completion: nil)
            }
            else if (atleastOneTie)
            {
                var placeBetAlert = UIAlertController(title: "Game Over" ,message: "Players: \(tieList) tie with the dealer !!",preferredStyle:UIAlertControllerStyle.Alert)
                placeBetAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(placeBetAlert, animated: true, completion: nil)
            }
            
         
        }
        hitButton.hidden = true
        standButton.hidden = true
        resetButton.hidden = false
        if(haveBalance) {
        nextGameButton.hidden = false
        }

    }
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func playerPlay(var playerNumber:Int) {
        if(playerNumber <= numberOfPlayers - 1) {
            players[playerNumber].hand.cards.append(shoe[0])
            playerHandLabel.text = players[playerNumber].hand.showHand()
            shoe.removeAtIndex(0)
            players[playerNumber].score = players[playerNumber].hand.getscore()
            playerScoreLabel.text = "\(players[playerNumber].score)  "
            if(players[playerNumber].score > 21){
                players[playerNumber].busted = true
                playerBusted(currentPlayerNumber)
            }
            else if(players[playerNumber].score == 21)
            {
                var placeBetAlert = UIAlertController(title: "Player \(playerNumber + 1) wins" ,message: "BlackJack!!",preferredStyle:UIAlertControllerStyle.Alert)
                placeBetAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: dealBustedAndBlackJack))
                presentViewController(placeBetAlert, animated: true, completion: nil)
            }
        }
        else
        {
            lastDealerPlay()
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func loadPlayerEnvironment(var playerNumber:Int) {
        playerHandLabel.text = players[playerNumber].hand.showHand()
        playerScoreLabel.text = "\(players[playerNumber].score)  "
        playerBalanceLabel.text = "\(players[playerNumber].balance)"
        playerIdentifierLabel.text = "Player \(players[playerNumber].playerNumber + 1)"
        
    }
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func playerBusted(var playerNumber: Int) {
            
        if(playerNumber < numberOfPlayers){
            var placeBetAlert = UIAlertController(title: "Busted" ,message: "Player \(currentPlayerNumber + 1) Busted !",preferredStyle:UIAlertControllerStyle.Alert)
            placeBetAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: dealBustedAndBlackJack))
            presentViewController(placeBetAlert, animated: true, completion: nil)
            players[playerNumber].balance = players[playerNumber].balance -  players[playerNumber].betAmount
            //Get Next Play
    }
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func dealerBusted() {
            var placeBetAlert = UIAlertController(title: "Busted" ,message: "Dealer Busted !",preferredStyle:UIAlertControllerStyle.Alert)
            placeBetAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: dealBustedAndBlackJack))
            presentViewController(placeBetAlert, animated: true, completion: nil)
        
        hitButton.hidden = true
        standButton.hidden = true
        resetButton.hidden = false
        nextGameButton.hidden = false
        
        for playerNumber in 0...numberOfPlayers-1 {
            if( !players[playerNumber].busted) {
            players[playerNumber].balance = players[playerNumber].balance + 2 * players[playerNumber].betAmount
            }
        }

        
        
        }
    

    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func dealBustedAndBlackJack(alert: UIAlertAction!) {
        if(dealer.busted) {
            
            hitButton.hidden = true
            standButton.hidden = true
            resetButton.hidden = false
            nextGameButton.hidden = false
            
        }
        else
        {

            if(currentPlayerNumber < numberOfPlayers-1)
            {
                currentPlayerNumber++
                loadPlayerEnvironment(currentPlayerNumber)
            }
            else
            {
                lastDealerPlay()
            }
        }
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @IBAction func hitClicked(sender: AnyObject) {
        playerPlay(currentPlayerNumber)
    }
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @IBAction func standClicked(sender: AnyObject) {
        currentPlayerNumber++
        while(currentPlayerNumber <= numberOfPlayers - 1)
        {   if(players[currentPlayerNumber].noBalance()) {
               currentPlayerNumber++
            }
            else
            {
            break
            }
        }
        
        if(currentPlayerNumber <= numberOfPlayers - 1) {
        loadPlayerEnvironment(currentPlayerNumber)
        }
        else
        {
            lastDealerPlay()
        }
    }
    
  
    override func prepareForSegue( segue:UIStoryboardSegue, sender: AnyObject?) {
        if(!(segue.identifier == "ResetSegue"))
        {
        var DestViewController : GameController = segue.destinationViewController as GameController
       
            for (var i = numberOfPlayers - 1; i >= 0; i--) {
                if(players[i].noBalance())
                {
                    players.removeAtIndex(i)
                    numberOfPlayers = numberOfPlayers - 1
                }
            }
                
   
                DestViewController.players = players
                DestViewController.numberOfPlayers = numberOfPlayers
                DestViewController.numberOfDecks = numberOfDecks
            
        }
        
    }

    
    
}
