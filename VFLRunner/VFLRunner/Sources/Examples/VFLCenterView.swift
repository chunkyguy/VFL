//
//  VFLCenterView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 01/07/2023.
//

import UIKit
import WLKit

// Add a subview of fixed size and pinned to the center of parent
class VFLCenterView: VFLExampleView {
  override func setUp() {
    super.setUp()
    
    let view = VFLColorView()
    VFL(self)
      .add(subview: view, name: "view")
      .applyConstraints(formats: [
        "H:[view(200)]", "V:[view(200)]"
      ])
      .applyConstraints(constraints: [
        view.centerXAnchor.constraint(equalTo: centerXAnchor),
        view.centerYAnchor.constraint(equalTo: centerYAnchor)
      ])
  }
}
