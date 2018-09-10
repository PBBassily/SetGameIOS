//
//  Set.swift
//  SetGame
//
//  Created by Paula Boules on 9/9/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import Foundation

struct Set : CustomStringConvertible{
    var description: String {
        return String(num.rawValue)+" "+String(symbol.hashValue)
    }
    
    
    var num :Num, symbol:Symbol, color:Color, shading:Shading
    var selected  : Bool
    
    enum Num : Int {
        case one = 1
        case two = 2
        case three = 3
        
        static var all : [Num]{
            return [.one, .two, .three]
        }
    }
    
    enum Symbol {
        case symbol1
        case symbol2
        case symbol3
        
        static var all : [Symbol]{
            return [.symbol1, .symbol2, .symbol3]
        }

    }
    
    enum Color {
        case color1
        case color2
        case color3
        
        static var all : [Color]{
            return [.color1, .color2, .color3]
        }
    }
    
    enum Shading {
        case solid
        case striped
        case open
        
        
        static var all : [Shading]{
            return [.solid, .striped, .open]
        }
    }
    
}

extension Set {
    
    static var getAllNums : [Num] {
        return Num.all
    }
    static var getAllSymbols : [Symbol] {
        return Symbol.all
    }
    static var getAllShadings : [Shading] {
        return Shading.all
    }
    static var getAllColors : [Color] {
        return Color.all
    }
}
