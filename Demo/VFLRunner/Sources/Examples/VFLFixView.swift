//
//  VFLFixView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 01/07/2023.
//

import UIKit
import VFL

// Pin subview of size 100x100 to top-left corner with default spacing
class VFLFixView: VFLExampleView {
  override func setUp() {
    super.setUp()
    VFL(self)
      .add(subview: VFLColorView(), name: "view")
      .appendConstraints(formats: [
        "V:|-[view(100)]",
        "H:|-[view(100)]"
      ])
  }
}
