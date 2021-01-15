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
    
    public class var trackerColor: UIColor{
        return UIColor(hexString: "#50596c")
    }
    
    
    public class var gradientDefaultPink: [UIColor]{
        return [UIColor(hexString: "#e68080"), UIColor(hexString: "#9b457d")]
    }
    
    public class var gradientDefaultGreen: [UIColor]{
        return [UIColor(hexString: "#8ab94d"), UIColor(hexString: "#3b8080")]
    }
    
    public class var gradientDefaultBlue: [UIColor]{
        return [UIColor(hexString: "#48b8e9"), UIColor(hexString: "#4c80be")]
    }
    
    public class var gradientDefaultOrange: [UIColor]{
        return [UIColor(hexString: "#ffa250"), UIColor(hexString: "#df805c")]
    }
    
    public class var gradientDefaultPurple: [UIColor]{
        return [UIColor(hexString: "#ae80d0"), UIColor(hexString: "9767d7")]
    }
    
    public class var gradientDefaultYellow: [UIColor]{
        return [UIColor(hexString: "ffe35d"), UIColor(hexString: "d3ba5c")]
    }
    
}
