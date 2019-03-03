//
//  ViewController.swift
//  Concentration
//
//  Created by Islam Gharib on 12/23/18.
//  Copyright © 2018 Gharib. All rights reserved.
//

import UIKit

class ConcentrationVC: UIViewController {
    
    // this var responsible for starting the game
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // read only(get) computed property -> this is var is not stored in memory and is safe
    var numberOfPairsOfCards:Int{
        return (cardButtons.count + 1)/2
    }

    // store number of flibs and change label result
    private(set) var flipCount = 0{
        didSet{
            // flibCountLB.text = "Flips: \(flipCount)"
            updateFlipCountLB()
        }
    }
    // update flipCount
    private func updateFlipCountLB(){
        let attributes:[NSAttributedStringKey:Any] = [
            .strokeWidth:5.0,
            .strokeColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flibCountLB.attributedText = attributedString
    }
    @IBOutlet private weak var flibCountLB: UILabel!{
        didSet{
            updateFlipCountLB()
        }
    }
    
    // outlet collection of all card buttons
    @IBOutlet private var cardButtons: [UIButton]!
    
    // when any of cardbuttons pressed increase the flipcont and invoke flipCard func
    @IBAction private func touchCard(_ sender: UIButton) {
        // game.chooseCard(at: 20)
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        }else{
            print("chosen card was not in carsButtons")
        }
    }
    
    // this var resposible for restarting the game when restartGame = 0
    private lazy var restartGame:Int = cardButtons.count
    
    // update the cards (view) after each click on the card
    private func updateViewFromModel(){
        for index in cardButtons.indices{ // .indices mean 0..<cardButtons.count
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp, !card.isMatched{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
            else if card.isFaceUp, card.isMatched{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                button.isEnabled = false
                restartGame -= 1
                // print(restartGame)
            }else if !card.isFaceUp,!card.isMatched{
                button.setTitle("", for: UIControlState.normal)
                //button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                    button.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            }
            
            if restartGame == 0{
                let appDelegate = AppDelegate()
                appDelegate.resetApp()
            }
            
            /*
             if card.isFaceUp{
             button.setTitle(emoji(for: card), for: UIControlState.normal)
             button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
             }else{
             button.setTitle("", for: UIControlState.normal)
             button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
 
             if card.isMatched{
             button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
             button.isEnabled = false
             }else{
             button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
             }
            */
           }
            
        
    }
    
    // default theme
    var theme:String? {
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
                    // using array of emojiChoices
    //private var emojiChoices = ["😈","👻","🎃","😱","🦇","🙀","🍎","🚴🏿‍♂️","🏆"]
                    // using String of emojiChoices
    private var emojiChoices = "😈👻🎃😱🦇🙀🍎🚴🏿‍♂️🏆"
    // using the card insteas of its identifier by making it implement Hashable protocol
    private var emoji = [Card:String]()
    private func emoji(for card:Card)->String{
        // create a random emoji for every card
        if(emoji[card] == nil), emojiChoices.count>0{
                        // using remove at to ensure the unique emoji -> using the array
                //emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            // using remove at to ensure the unique emoji -> using the String
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension Int{
    var arc4random:Int{
        if self>0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self<0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{return 0}
    }
    
}
