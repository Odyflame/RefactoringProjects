//
//  ConfettiView.swift
//  VocaGame
//
//  Created by Hanteo on 2021/03/18.
//

import Foundation
import UIKit
import VocaDesignSystem

class ConfettiView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        emitter.emitterPosition = CGPoint(x: center.x, y: -96)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: frame.size.width, height: 1)
    }
    
    let emitter = CAEmitterLayer()
    
    func configureConfettiLayer() {
        emitter.emitterPosition = CGPoint(x: center.x, y: -96)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: frame.size.width, height: 1)
        emitter.emitterCells = getEmiiterCells()
        self.layer.addSublayer(emitter)
    }

    func getEmiiterCells() -> [CAEmitterCell] {
        var cells:[CAEmitterCell] = [CAEmitterCell]()
        for index in 0..<2 {
            let cell = CAEmitterCell()
            cell.birthRate = 3
            cell.lifetime = 10.0
            cell.lifetimeRange = 3
            cell.velocity = 10
            cell.velocityRange = 0
            cell.color = getColor(index: index).cgColor
            cell.contents = UIImage(named: "confetti")?.cgImage
            cell.scaleRange = 0
            cell.scale = 0.3
            cell.velocityRange = 90
            cell.yAcceleration = 30
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 90
            cells.append(cell)
        }
        return cells
    }

    func getColor(index: Int) -> UIColor {
        ((index % 2) != 0) ? UIColor.dandelion : UIColor.confettiBlue
    }
    
}
