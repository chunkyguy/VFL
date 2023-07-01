//
//  VFLFixView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 01/07/2023.
//

import UIKit
import VFL

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
