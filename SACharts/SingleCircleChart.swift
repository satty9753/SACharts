//
//  CircleView.swift
//  ProjectCircle
//
//  Created by michelle on 2019/12/5.
//  Copyright © 2019 michelle. All rights reserved.
//

import UIKit

public class SingleCircleChart: UIView {

    private let renderer = CircleRenderer()
    
    private (set) var value: Float = 0
    
    var minimunValue: Float = 0
    
    var maximunValue: Float = 1
    
    var isContinuous = true
    
    private func commonInit(){
        renderer.updateBounds(bounds)
        renderer.trackColor = .trackerColor
        renderer.progressColor = .red
        renderer.lineWidth = 15
        layer.addSublayer(renderer.trackLayer)
    }
    
    public var trackerColor: UIColor{
        get{ return renderer.trackColor }
        set{ renderer.trackColor  = newValue }
    }
    
    public var lineWidth: CGFloat{
        get{ return renderer.lineWidth }
        set{ renderer.lineWidth = newValue }
    }
    
    public var startAngle: CGFloat {
      get { return renderer.startAngle }
      set { renderer.startAngle = newValue }
    }

    public var endAngle: CGFloat {
      get { return renderer.endAngle }
      set { renderer.endAngle = newValue }

    }
    
    public override init(frame: CGRect) {
       super.init(frame: frame)
       commonInit()
     }

    public required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       commonInit()
     }
    
    public func drawSingleArc(percentValue: Float, color:[UIColor], animated: Bool = false){
        guard percentValue >= 0 && percentValue <= 1 else{
            print("The percent Value should be in the range of 0 and 1.")
            return
        }
        layer.addSublayer(renderer.progressLayer)
        renderer.gradientLayer.frame = self.frame
        layer.addSublayer(renderer.gradientLayer)
        
        value = min(maximunValue, max(minimunValue, percentValue))
        let angleRange = endAngle - startAngle
        let valueRange = maximunValue - minimunValue
        let angleValue = CGFloat(value-minimunValue) / CGFloat(valueRange) * angleRange + startAngle
        renderer.setProgressAngle(angleValue: Float(angleValue), colors: color, animated: animated)
    }
    
    public func drawPieChart(value:[Float], gradientColors:[[UIColor]]){
        drawMultipleArcs(chart: .pieChart, values: value, gradientColors: gradientColors)
    }
    
    public func drawArcsChart(value:[Float], gradientColors:[[UIColor]]){
        drawMultipleArcs(chart: .arcsChart, values: value, gradientColors: gradientColors)
    }
    
    private func drawMultipleArcs(chart:Chart, values:[Float], gradientColors:[[UIColor]], animated: Bool = false){
        let totalValues = values.reduce(0,{ $0+$1 })
        let portions = values.map { $0/totalValues }
        let angleRange = endAngle - startAngle
        let valueRange = maximunValue - minimunValue
        let angleValues = portions.map{ CGFloat($0 - minimunValue)/CGFloat(valueRange) * angleRange}
        
        renderer.setProgressLayers(chart: chart, angleValues: angleValues, gradientColors: gradientColors, animated: animated)
        
        for count in 0..<renderer.progressLayers.count{
            layer.addSublayer(renderer.progressLayers[count])
            renderer.gradientLayers[count].frame = self.frame
            layer.addSublayer(renderer.gradientLayers[count])
            renderer.gradientLayers[count].mask = renderer.progressLayers[count]
        }
        
    }
    
    

}
