//
//  CirclesView.swift
//  CEOApp
//
//  Created by michelle on 2019/12/13.
//  Copyright © 2019 michelle. All rights reserved.
//

import Foundation
import UIKit

class CirclesView: UIView {

    private let renderer = CirclesRenderer()
    
    private (set) var value: Float = 0
    
    var minimunValue: Float = 0
    
    var maximunValue: Float = 0.15
    
    let numberLabel = UILabel()
    
    var isContinuous = true
    
    var circles: Int = 0
    
    var colors = [UIColor]()
    
    private func commonInit(){
        renderer.updateBounds(bounds)
        
    }
    
    var lineWidth: CGFloat{
        get{ return renderer.lineWidth }
        set{ renderer.lineWidth = newValue }
    }

    var startAngle: CGFloat {
      get { return renderer.startAngle }
      set { renderer.startAngle = newValue }
    }

    var endAngle: CGFloat {
      get { return renderer.endAngle }
      set { renderer.endAngle = newValue }
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       commonInit()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       commonInit()
     }
    
    
    func setValues(_ contents:[String], colors:[[UIColor]]){
        renderer.updateBounds(bounds)
        renderer.setTrackLayerPath(division: contents.count)
        for l in renderer.trackLayers{
            layer.addSublayer(l)
        }

        renderer.setProgressLayerPath(colors: colors)
        
        for count in 0..<renderer.progressLayers.count{
            layer.addSublayer(renderer.progressLayers[count])
            renderer.gradientLayers[count].frame = self.frame
            layer.addSublayer(renderer.gradientLayers[count])
            renderer.gradientLayers[count].mask = renderer.progressLayers[count]
        }

    }
    
    func updateValues(values:[Float], animated: Bool = false){
        let total = values.reduce(0, {$0+$1})
        let portions = values.map{ $0/total }
        let angleRange = endAngle - startAngle
        let valueRange = maximunValue - minimunValue
//        let angleValues = portions.map{ CGFloat($0 - minimunValue)/CGFloat(valueRange) * angleRange + startAngle }
        let angleValues = portions.map{ CGFloat($0*valueRange) * CGFloat(angleRange) + startAngle }
        renderer.updateProgressLayerPath(angleValues: angleValues, animated: animated)
    }

}
