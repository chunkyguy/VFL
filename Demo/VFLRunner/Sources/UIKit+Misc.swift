//
//  UIView+Misc.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

extension UIColor {
  static var random: UIColor {
    return UIColor(
      hue: CGFloat.random(in: 0...1),
      saturation: 0.8, brightness: 0.8, alpha: 1
    )
  }
}

extension UIView {
  static func create(color: UIColor = .random) -> UIView {
    let vw = UIView(frame: .zero)
    vw.backgroundColor = color
    return vw
  }
}

extension UIEdgeInsets {
  var metrics: [String: CGFloat] {
    return [ "top": self.top, "bottom": self.bottom, "left": self.left, "right": self.right]
  }
}
