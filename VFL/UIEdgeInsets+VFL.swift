//
//  UIEdgeInsets+VFL.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

extension UIEdgeInsets {
    var metrics: [String: CGFloat] {
        return [
            "top": self.top,
            "bottom": self.bottom,
            "left": self.left,
            "right": self.right
        ]
    }
}
