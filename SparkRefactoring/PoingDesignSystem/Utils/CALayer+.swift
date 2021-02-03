//
//  CALayer+.swift
//  Vocabulary
//
//  Created by LEE HAEUN on 2020/08/10.
//  Copyright © 2020 LEE HAEUN. All rights reserved.
//

import UIKit

public class Shadow {
    public init(color: UIColor, x: CGFloat, y: CGFloat, blur: CGFloat) {
        self.color = color
        self.x = x
        self.y = y
        self.blur = blur
    }
    
    let color: UIColor
    let x: CGFloat
    let y: CGFloat
    let blur: CGFloat
}

public extension CALayer {
    func shadow(_ shadow: Shadow) {
        sha
    }
}
