//
//  Card.swift
//  MilestoneProject28-30
//
//  Created by Yury Popov on 22/08/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import Foundation

struct Card {
    let name: String
    var isMatch = false
    var isShown = false
    
    
    static func createCards(names: [String]) -> [Card] {
        var cards = [Card]()
        for name in names {
            if cards.count > 12 - 1{
                break
            } else {
            }
            let card = Card(name: name, isMatch: false, isShown: false)
            cards.append(card)
            cards.insert(card, at: 0)
        }
        return cards
        
    }
}
