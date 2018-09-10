//
//  SetDeck.swift
//  SetGame
//
//  Created by Paula Boules on 9/9/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import Foundation

struct SetDeck {
    
    private(set) var setCards = [Set]()
    
    init () {
        for num in Set.getAllNums {
            for symbol in Set.getAllSymbols {
                for shading in Set.getAllShadings {
                    for color in Set.getAllColors {
                        setCards.append(Set(num: num, symbol: symbol, color: color, shading: shading, selected: false))
                        
                    }
                }
            }
        }
    }
    
    private mutating func drawSetCard() -> Set {
        return setCards.remove(at: setCards.count.randomIndex)
    }
    
    mutating func drawThreeSetCards() -> [Set] {
//        return Array<Set>(repeating: drawSetCard(), count: 3)
        
        var initBoardCards = [Set]()
        for _ in 1 ... 3 {
            initBoardCards.append(drawSetCard())
        }
        return initBoardCards
    }
    
    mutating func drawTwelveSetCards() -> [Set] {
        var initBoardCards = [Set]()
        for _ in 1 ... 12 {
            initBoardCards.append(drawSetCard())
//            print(String(initBoardCards.count)+" "+String(setCards.count))
        }
        return initBoardCards
    }
}

extension Int {
    var randomIndex : Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
