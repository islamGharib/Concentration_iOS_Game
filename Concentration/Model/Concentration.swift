//
//  Concentration.swift
//  Concentration
//
//  Created by Islam Gharib on 12/24/18.
//  Copyright © 2018 Gharib. All rights reserved.
//

import Foundation

// this is class is the mediator between the model and controller
// convert class to struct by making func that change property value mutating func
struct Concentration{
    private(set) var cards = [Card]()
    
    // computed property
    private var indexOfOneAndOnlyFaceUpCard:Int?{
        get{
            // using closure as property inisialization
            /*
            let faceUpCardIndices = cards.indices.filter{cards[$0].isFaceUp}
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first:nil
            */
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
            /*
            var foundIndex:Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
            */
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue) // newvalue call the get
            }
        }
    }
    mutating func chooseCard(at index:Int){
        // index must exist into cards[]
        //assert(!cards.indices.contains(index), "Concentration.chooseCard(at index:\(index)): chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
               // indexOfOneAndOnlyFaceUpCard = nil
            }else{
                /*
                for faceDownIndex in cards.indices{
                    cards[faceDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                */
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards:Int) {
        // numberOfPairsOfCards must be >0
        //assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards:\(numberOfPairsOfCards): you must have least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card] // this is equal cards.append(card) , cards.append(card)
        }
        // TODO: Shuffle the cards
        cards.shuffle()
        // print(cards[0].identifier)
    }
    
}
// add shuffle func to array to shuffle your cards randomly
extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in indices
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

extension Collection{
    var oneAndOnly:Element?{
        return count==1 ? first:nil
    }
}
