//
//  Card.swift
//  Concentration
//
//  Created by Islam Gharib on 12/24/18.
//  Copyright © 2018 Gharib. All rights reserved.
//

import Foundation
// this is struct is the model of card object
struct Card: Hashable {
    // implement Hashable members
    var hashValue:Int{return identifier}
    static func ==(lhs:Card, rhs:Card)-> Bool{
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier:Int
    
    // make a unique identifier for each card
    private static var identifierFactory = 0
    private static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
