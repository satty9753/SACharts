//
//  UIColorExtension.swift
//  CEOApp
//
//  Created by michelle on 2019/12/19.
//  Copyright © 2019 michelle. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexInt: UInt32 = 0
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)

        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        let alpha = alpha

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public class var mainColor: UIColor{
        //#1a2b43
        return UIColor(red:0.10, green:0.17, blue:0.26, alpha:1.0)
    }
    public class var labelDisplayColor: UIColor{
        return .white
    }
    
    public class var contentColor: UIColor{
        return UIColor(hexString: "#233753")
    }
    
    public class var trackerColor: UIColor{
        return UIColor(hexString: "#50596c")
    }
    
    public class var ceoGray: UIColor{
        return UIColor(hexString: "#a8a8a8")
    }
    
    public class var ceoYellow: UIColor{
        return UIColor(red:0.91, green:0.79, blue:0.00, alpha:1.00)
    }
    
    public class var chartPink: UIColor{
        return UIColor(hexString: "#e68080")
    }
    
    public class var chartGreen: UIColor{
        return UIColor(hexString: "#8ab94d")
    }
    
    public class var chartBlue: UIColor{
        return UIColor(hexString: "#48b8e9")
    }
    
    public class var chartOrange: UIColor{
        return UIColor(hexString: "#ffa250")
    }
    
    public class var chartPurple: UIColor{
        return UIColor(hexString: "#ae80d0")
    }
    
    public class var contentViewBgColor: UIColor{
         return UIColor(hexString: "#233752")
    }
    
    public class var gradientPink: [UIColor]{
        return [chartPink, UIColor(hexString: "#9b457d")]
    }
    
    public class var gradientGreen: [UIColor]{
        return [chartGreen, UIColor(hexString: "#3b8080")]
    }
    
    public class var gradientBlue: [UIColor]{
        return [chartBlue, UIColor(hexString: "#4c80be")]
    }
    
    public class var gradientOrange: [UIColor]{
        return [chartOrange, UIColor(hexString: "#df805c")]
    }
    
    public class var gradientPurple: [UIColor]{
        return [chartPurple, UIColor(hexString: "9767d7")]
    }
    
    public class var gradientYellow: [UIColor]{
        return [UIColor(hexString: "ffe35d"), UIColor(hexString: "d3ba5c")]
    }
    
    public class var globalPink: [UIColor]{
        return [UIColor(hexString:"ff4d96"), UIColor(hexString: "ea397d"),  UIColor(hexString:"a02b52")]
    }
    
    public class var globalGreen: [UIColor]{
        return [UIColor(hexString:"89d836"), UIColor(hexString: "67d329"),  UIColor(hexString:"1ca06d")]
    }
    
    public class var globalBlue: [UIColor]{
        return [UIColor(hexString:"22f5ff"),  UIColor(hexString: "0091ff"), UIColor(hexString:"0c6df4")]
    }
    
    public class var globalOrange: [UIColor]{
        return [UIColor(hexString:"f0bc42"), UIColor(hexString:"d89e0b"), UIColor(hexString:"c87b3e")]
    }
    
    public class var globalPurple: [UIColor]{
           return [UIColor(hexString:"9267d5"), UIColor(hexString:"884dd4"), UIColor(hexString:"8034d4")]
    }
    
}
