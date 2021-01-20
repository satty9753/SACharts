//
//  CirclesRender.swift
//  CEOApp
//
//  Created by michelle on 2019/12/13.
//  Copyright © 2019 michelle. All rights reserved.
//

import Foundation
import UIKit

class CirclesRenderer{
    var trackColor: UIColor = .trackerColor{
           didSet{
            trackLayers.forEach{ $0.strokeColor = trackColor.cgColor }
           }
       }
    var lineWidth: CGFloat = 20{
        didSet{
            trackLayers.forEach{ $0.lineWidth = lineWidth }
        }
    }
    var startAngle: CGFloat = CGFloat(Double.pi/2){
        didSet{
            setTrackLayerPath(division: division)
        }
    }
    var endAngle: CGFloat = CGFloat(Double.pi*2){
        didSet{
            setTrackLayerPath(division: division)
        }
    }
    
    var bounds: CGRect?
    
    private var division = Int()

    var trackLayers = [CAShapeLayer]()
    var progressLayers = [CAShapeLayer]()
    
    var gradientLayers = [CAGradientLayer]()
    
    func updateBounds(_ bounds: CGRect) {
        self.bounds = bounds
    }
    
    func setTrackLayerPath(division: Int){
        trackLayers = []
        guard let bounds = self.bounds else { return }
               self.division = division
               let center = CGPoint(x: bounds.midX, y: bounds.midY)
               let maxRadius = min(bounds.width-10, bounds.height-10)/2
        for i in (1...self.division).reversed(){
             let radius = maxRadius/CGFloat(division) * CGFloat(i)
             let ring = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
             let trackLayer = CAShapeLayer()
             //default setting
             trackLayer.lineWidth = 10
             trackLayer.path = ring.cgPath
             trackLayer.fillColor = UIColor.clear.cgColor
             trackLayer.strokeColor = UIColor.trackerColor.cgColor
             trackLayer.lineCap = CAShapeLayerLineCap.round
             trackLayers.append(trackLayer)
         }
    }
    
    func setProgressLayerPath(colors:[[UIColor]]){
        progressLayers = []
        var count = 0
        for _ in (1...self.division).reversed(){

            let progressLayer = CAShapeLayer()
            progressLayer.lineWidth = 8
            progressLayer.fillColor = UIColor.clear.cgColor
            progressLayer.strokeColor = UIColor.white.cgColor
            progressLayer.lineCap = CAShapeLayerLineCap.round
            progressLayers.append(progressLayer)
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = colors[count].map{ $0.cgColor }
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayers.append(gradientLayer)
            count+=1
              
        }
          
    }
    
    func updateProgressLayerPath(angleValues:[CGFloat], animated: Bool){
        guard let bounds = self.bounds else { return }
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let maxRadius = min(bounds.width-10, bounds.height-10)/2
        
        var count = 0
        for i in (1...self.division).reversed(){
            let radius = maxRadius/CGFloat(division) * CGFloat(i)
            let progressEndAngle = angleValues[count]
            let ring = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: progressEndAngle, clockwise: true)
            progressLayers[count].path = ring.cgPath
            count+=1
        }
        
    }
}
