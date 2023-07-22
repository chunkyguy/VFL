//
//  VFLFullView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 01/07/2023.
//

import UIKit
import VFL

// Pin subview to all edges
class VFLFullView: VFLExampleView {
  override func setUp() {
    super.setUp()
    VFL(self)
      .add(subview: VFLColorView(), name: "view")
      .appendConstraints(formats: ["H:|[view]|", "V:|[view]|"])
  }
}
