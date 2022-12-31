//
//  UIView+Misc.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

extension UIView {
    static func create() -> UIView {
        let vw = UIView(frame: .zero)
        vw.backgroundColor = UIColor(hue: CGFloat.random(in: 0...1), saturation: 0.8, brightness: 0.8, alpha: 1)
        return vw
    }
}
