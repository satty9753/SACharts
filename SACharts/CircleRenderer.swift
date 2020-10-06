//
//  CircleRender.swift
//  ProjectCircle
//
//  Created by michelle on 2019/12/5.
//  Copyright © 2019 michelle. All rights reserved.
//

import Foundation
import UIKit

class CircleRenderer{
    var progressColor: UIColor = .blue{
        didSet{
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    var trackColor: UIColor = .lightGray{
           didSet{
               trackLayer.strokeColor = trackColor.cgColor
           }
       }
    var lineWidth: CGFloat = 8{
        didSet{
            trackLayer.lineWidth = lineWidth
            progressLayer.lineWidth = lineWidth
            updateTrackLayerPath()
        }
    }
    var startAngle: CGFloat = CGFloat(Double.pi/2){
        didSet{
            updateTrackLayerPath()
        }
    }
    var endAngle: CGFloat = CGFloat(Double.pi*5/2){
        didSet{
            updateTrackLayerPath()
        }
    }
    
    let trackLayer = CAShapeLayer()
    let progressLayer = CAShapeLayer()
    let gradientLayer = CAGradientLayer()
    var progressLayers = [CAShapeLayer]()
    var gradientLayers = [CAGradientLayer]()
    
    
    init() {
        trackLayer.fillColor = UIColor.clear.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
    }
    
    private func updateTrackLayerPath(){
        let bounds = trackLayer.bounds
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width-15, bounds.height-15)/2

        let ring = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        trackLayer.path = ring.cgPath

        trackLayer.shadowColor = UIColor.systemGray.cgColor
    }
    
    private func progressLayerAnimation(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        progressLayer.add(animation, forKey: nil)
    }
    
    func updateBounds(_ bounds: CGRect) {
      trackLayer.bounds = bounds
      progressLayer.bounds = bounds
      trackLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
      progressLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
      updateTrackLayerPath()
    }
    
    func setProgressAngle(angleValue:Float, colors:[UIColor],  animated: Bool){
        let bounds = progressLayer.bounds
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width-15, bounds.height-15)/2

        let ring = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: CGFloat(angleValue), clockwise: true)
        //round corner
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.strokeColor = colors[0].cgColor
        progressLayer.path = ring.cgPath
        
        guard colors.count > 1 else { return }
        
        gradientLayer.colors = colors.map{ $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.mask = progressLayer
      
        if animated{
            progressLayerAnimation()
        }
        
    }
    
    func setProgressLayers(chart:Chart, angleValues:[CGFloat], gradientColors:[[UIColor]], animated: Bool){
        let bounds = progressLayer.bounds
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width-15, bounds.height-15)/2
        
        var progressStartAngle:CGFloat = startAngle
        
        for i in 0..<angleValues.count{
            let progressAngle = angleValues[i]
            let layer = CAShapeLayer()
            layer.lineCap = CAShapeLayerLineCap.round
            
            var ring: UIBezierPath!
            switch chart {
            case .arcsChart:
                ring = UIBezierPath(arcCenter: center, radius: radius, startAngle: progressStartAngle, endAngle: -progressAngle + progressStartAngle, clockwise: false)
                layer.strokeColor = gradientColors[i][0].cgColor
                layer.fillColor = UIColor.clear.cgColor
            case .pieChart:
                ring = UIBezierPath()
                ring.move(to: center)
                ring.addArc(withCenter: center, radius: radius, startAngle: progressStartAngle, endAngle: -progressAngle + progressStartAngle, clockwise: false)
                ring.close()
                
                layer.strokeColor = UIColor.clear.cgColor
                layer.fillColor = gradientColors[i][0].cgColor
            default:
                print("default")
            }
           
            layer.path = ring.cgPath
            layer.lineWidth = lineWidth - 1.0
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = gradientColors[i].map{ $0.cgColor }
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.1, y: 1.0)
            
            gradientLayers.append(gradientLayer)
            
            progressLayers.append(layer)
            progressStartAngle -= progressAngle
        }
        
        guard angleValues.count > 0 && !angleValues.first!.isNaN else{
            return
        }

        let colorIndex = self.getFirstIndex(array: angleValues)
        
        guard angleValues[colorIndex] > 0.205 && chart == .singleArcChart else{ return }
        
        let extraLayer = CAShapeLayer()

        extraLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: startAngle - CGFloat(Double.pi/720), clockwise: false).cgPath
        extraLayer.strokeColor = gradientColors.first![0].cgColor
        extraLayer.fillColor = UIColor.clear.cgColor
        extraLayer.lineWidth = lineWidth - 1.0
        extraLayer.lineCap = CAShapeLayerLineCap.round

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors[colorIndex].map{ $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 1.0)

        progressLayers.append(extraLayer)
        gradientLayers.append(gradientLayer)
        
    }
    
    func getFirstIndex(array:[CGFloat])->Int{
        var index = 0
        for value in array{
            if value != 0.0{
               return index
            }
            index += 1
        }
        return index
    }
}
