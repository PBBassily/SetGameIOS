//
//  SetCardUI.swift
//  SetGame
//
//  Created by Paula Boules on 9/9/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

@IBDesignable
class SetCardUI: UIView {
    
    
     var num   = 3 {didSet {setNeedsDisplay()}}
    
     var color  = SymbolColor.color1 {didSet {setNeedsDisplay()}}
    
     var symbol  = Symbol.symbol1 {didSet {setNeedsDisplay()}}
    
     var shading  = ShadingStyle.striped {didSet {setNeedsDisplay()}}
    
    var isHiddenCard: Bool = true {didSet {setNeedsDisplay()}}
    var isSelected : Bool = false {didSet{setNeedsDisplay()}}
    var index : Int = -1
    
    
    
    func initTapRecognizer() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        print("hello from code")
        isSelected =  !isSelected
    }
    
    private lazy var symbolLabel = createUILabel()
    
    
    private func createUILabel () -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0 //  as many as you want
        addSubview(label)
        return label
        
    }
    private func configureLayout(label : UILabel) {
        label.attributedText = symbolString
        label.frame.size = CGSize.zero
        label.sizeToFit()
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureLayout(label : symbolLabel)
        symbolLabel.center.x = bounds.midX
        symbolLabel.center.y = bounds.midY
        
    }
    
    private func centeredAttributedString(_ string : String, fontSize: CGFloat)->NSAttributedString{
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        return NSAttributedString(string: string, attributes: [NSAttributedStringKey.paragraphStyle : paragraphStyle, .font : font, NSAttributedStringKey.foregroundColor : color.rawValue.withAlphaComponent(CGFloat(shading.rawValue)), NSAttributedStringKey.strokeColor: color.rawValue, NSAttributedStringKey.strokeWidth: -10])
    }
    
    private var symbolString :NSAttributedString {
        return centeredAttributedString(String(String(repeating: symbol.rawValue+"\n", count: num).dropLast()), fontSize: CGFloat(45/num))
    }
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
        UIColor(red: 247.0, green: 245.0, blue: 230.0, alpha: 1).setFill()
        path.fill()
        
        path.lineWidth = 10
        
        
        
        if !isHiddenCard {
           self.alpha = 1
            if isSelected {
                UIColor.black.setStroke()
               
            }else {
                UIColor.clear.setStroke()
                
            }
            path.stroke()
        } else {
            self.alpha = 0
        }
        
        initTapRecognizer()
    }
    
    enum SymbolColor : RawRepresentable {
        typealias RawValue = UIColor
        
        case color1
        case color2
        case color3
        
        init?(rawValue: RawValue) {
            switch rawValue {
            case UIColor.red: self = .color1
            case UIColor.green: self = .color2
            case UIColor.blue: self = .color3
            default: return nil
            }
        }
        
        var rawValue: RawValue {
            switch self {
            case .color1: return UIColor.red
            case .color2: return UIColor.green
            case .color3: return UIColor.blue
            }
        }
    }
    
    enum ShadingStyle : Double {
        case open = 0.0
        case striped = 0.25
        case fill = 1.0
    }
    
    enum Symbol : String {
        case symbol1 = "▲"
        case symbol2 = "●"
        case symbol3 = "■"
     }
    
}


