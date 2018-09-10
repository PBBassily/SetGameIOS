//
//  ViewController.swift
//  SetGame
//
//  Created by Paula Boules on 9/9/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var board: [SetCardUI]!
    
    var setCardsDeck = SetDeck()
    var availablePos = [Int]()
    
    
    lazy var setCards = self.setCardsDeck.drawTwelveSetCards()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        availablePos += 0...23
        initBoard (cards: setCards)
    }
    
    func initBoard(cards : [Set]) {
        //print(cards)
        
        for card in cards {
            
            let randomNum = availablePos.count.randomIndex
            let index = availablePos.remove(at:randomNum)
            print(String(card.description)+"->"+String(index))
            board[index].isHiddenCard = false
            board[index].color = parseColor(color: card.color)
            board[index].shading = parseShading(shading: card.shading)
            board[index].symbol = parseSymbol(symbol: card.symbol)
            board[index].num = card.num.rawValue
            
            
        }
    }
    func parseShading  (shading : Set.Shading) -> SetCardUI.ShadingStyle {
        switch shading {
        case .open:
            return SetCardUI.ShadingStyle.open
        case .striped:
            return SetCardUI.ShadingStyle.striped
        case .solid:
            return SetCardUI.ShadingStyle.fill
        }
    }
    func parseColor  (color : Set.Color) -> SetCardUI.SymbolColor {
        switch color{
        case .color1:
            return SetCardUI.SymbolColor.color1
        case .color2:
            return SetCardUI.SymbolColor.color2
        case .color3:
            return SetCardUI.SymbolColor.color3
        }
    }
    
    func parseSymbol  (symbol : Set.Symbol) -> SetCardUI.Symbol {
        switch symbol{
        case .symbol1:
            return SetCardUI.Symbol.symbol1
        case .symbol2:
            return SetCardUI.Symbol.symbol2
        case .symbol3:
            return SetCardUI.Symbol.symbol3
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        
        print("hello")
    }
    
}

