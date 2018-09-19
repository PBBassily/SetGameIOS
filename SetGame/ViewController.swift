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
    
    @IBOutlet weak var scoreLabel: UILabel!
    var setCardsDeck = SetDeck()
    var availablePos = [Int]()
    var candidates = [Int]()
    var mapping = [Int : Set]()
    var score : Int = 0 {didSet{
        scoreLabel.text="  Score: "+String(score)
        }}
    lazy var setCards = self.setCardsDeck.drawTwelveSetCards()
    
    @IBAction func NewGameButton(_ sender: UIButton) {
        setCardsDeck = SetDeck()
        setCards = self.setCardsDeck.drawTwelveSetCards()
        availablePos = [Int]()
        availablePos += 0...23
        candidates = [Int]()
        mapping = [Int : Set]()
        score = 0
        board.forEach({$0.isHiddenCard = true ; $0.isSelected = false})
        
        updateBoard(cards: setCards)
    }
    
    @IBAction func moreThreeCardsButton(_ sender: UIButton) {
        
        addThreeMoreCards()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        availablePos += 0...23
        updateBoard(cards: setCards)
        score = 0
    }
    
    func updateBoard(cards : [Set]) {
        
        
        for card in cards {
            
            let randomNum = availablePos.count.randomIndex
            let index = availablePos.remove(at:randomNum)
            print(String(card.description)+"->"+String(index))
            
            board[index].color = parseColor(color: card.color)
            board[index].shading = parseShading(shading: card.shading)
            board[index].symbol = parseSymbol(symbol: card.symbol)
            board[index].num = card.num.rawValue
            board[index].isHiddenCard = false
            mapping[index] = card
            
           
            
            board[index].isHiddenCard = false
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
    
    
    
    func  notifySelection(sender: SetCardUI) {
        
        if candidates.count == 3 {
            if(isMatched(set: [mapping[candidates[0]]!,mapping[candidates[1]]!,mapping[candidates[2]]!] )){
                // TODO inc score
                addAvailablePos()
                removeMapping()
                
                board[candidates[0]].isHiddenCard =  true
                board[candidates[1]].isHiddenCard =  true
                board[candidates[2]].isHiddenCard =  true
                
                
                addThreeMoreCards()
                
        
                
                
                score += 5
               
            }
            else {
                score -= 3
                
                // TODO dec score
            }
            board[candidates[0]].isSelected =  false
            board[candidates[1]].isSelected =  false
            board[candidates[2]].isSelected =  false
            
            candidates.removeAll();
        }
        
        if sender.isHiddenCard {
            print("redundant")
        } else if sender.isSelected {
            candidates.append(board.index(of: sender)!)
            print("added "+String(candidates.last!))
        } else if candidates.count > 0{
            candidates.remove(at: candidates.index(of: board.index(of: sender)!)!)
            print("deselection")
            
            score -= 1
        }
        
        
    }
    func isMatched (set : [Set]) -> Bool{
        let card1 = set[0], card2 = set[1], card3 = set[2]
        var rulesSatisfied = 0
        if card1.num == card2.num && card1.num == card3.num ||
            card1.num != card2.num && card1.num != card3.num && card2.num != card3.num {
            rulesSatisfied += 1
        } else {
            return false
        }
        
        if card1.symbol == card2.symbol && card1.symbol == card3.symbol ||
            card1.symbol != card2.symbol && card1.symbol != card3.symbol && card2.symbol != card3.symbol {
            rulesSatisfied += 1
        } else {
            return false
        }
        if card1.shading == card2.shading && card1.shading == card3.shading ||
            card1.shading != card2.shading && card1.shading != card3.shading && card2.shading != card3.shading {
            rulesSatisfied += 1
        } else {
            return false
        }
        
        if card1.color == card2.color && card1.color == card3.color ||
            card1.color != card2.color && card1.color != card3.color && card2.color != card3.color {
            rulesSatisfied += 1
        } else {
            return false
        }
        
        setCards.remove(at: setCards.index(of : card1)!)
        setCards.remove(at: setCards.index(of : card2)!)
        setCards.remove(at: setCards.index(of : card3)!)
        
        return true
    }
    
    func addThreeMoreCards() -> Bool{
        if(setCardsDeck.setCards.count > 0 && availablePos.count > 0){
            let threeCards = setCardsDeck.drawThreeSetCards()
            updateBoard(cards: threeCards)
            setCards.append(contentsOf: threeCards)
            return true
        }
            return false
    }
    
    func addAvailablePos() {
        availablePos.append(candidates[0])
        availablePos.append(candidates[1])
        availablePos.append(candidates[2])
        
        print(availablePos)
    }
    
    func removeMapping() {
        
        mapping[candidates[0]] = nil
        mapping[candidates[1]] = nil
        mapping[candidates[2]] = nil
    }
}



