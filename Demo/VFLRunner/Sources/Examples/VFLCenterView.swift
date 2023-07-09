//
//  VFLCenterView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 01/07/2023.
//

import UIKit
import VFL

// Add a subview of size 320x480 and pinned to the center of parent
class VFLCenterView: VFLExampleView {
  override func setUp() {
    super.setUp()
    
    let view = VFLColorView()
    VFL(self)
      .add(subview: view, name: "view")
      .appendConstraints(formats: [
        "H:[view(320)]",
        "V:[view(480)]"
      ])
      .appendConstraints([
        NSLayoutConstraint(
          item: view, attribute: .centerX,
          relatedBy: .equal,
          toItem: self, attribute: .centerX,
          multiplier: 1, constant: 0
        ),
        NSLayoutConstraint(
          item: view, attribute: .centerY,
          relatedBy: .equal,
          toItem: self, attribute: .centerY,
          multiplier: 1, constant: 0
        )
      ])
  }
}
