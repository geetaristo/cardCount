//
//  Dealer.swift
//  CardCount
//
//  Created by Michael Luttrell on 11/18/15.
//  Copyright © 2015 Michael Luttrell. All rights reserved.
//

import Foundation

class Dealer {

    var shoe = [String]()

    class var sharedInstance: Dealer {
        struct Singleton {
            static let instance = Dealer()
        }
        return Singleton.instance
    }
    
    init () {
        let cardSuits = ["♠️", "♣️", "♥️", "♦️"]
        let cardValues = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J" ,"Q", "K", "A"]

        var cardDictionary:Dictionary<String, Array<String>> = [:]
        let _ = cardSuits.map { cardDictionary[$0] = cardValues }
        
        let deckOfCards:Array<String> = cardDictionary.flatMap { (suit, values) in
            return values.map { return "\($0) \(suit)" }
        }
        shoe += deckOfCards
    }
    

    func getHighLowValue(card: String) -> Int {
        let cardComponents = card.componentsSeparatedByString(" ")
        if let value = Int(cardComponents[0]){
            switch value {
            case 2...6 :
                return 1
            case 7...9:
                return 0
            default:
                return -1
            }
        } else {
            return -1
        }
    }
    
    func shuffle () -> Array<String> {
        return shoe.shuffle()
    }
    
}


extension CollectionType {
    /// Return a copy of 'self' with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
//            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            let now = NSDate().timeIntervalSince1970
            let j = (Int( (Int(rand()) * Int(now))) + i) % 52
            print(j)
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

