//
//  VFLVSplitView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 01/07/2023.
//

import UIKit
import VFL

class VFLVSplitView: VFLExampleView {
  override func setUp() {
    super.setUp()
    VFL(self)
      .add(subview: VFLColorView(), name: "topVw")
      .add(subview: VFLColorView(), name: "bottomVw")
      .appendConstraints(formats: [
        "H:|[topVw]|", "H:|[bottomVw]|",
        "V:|[topVw(==bottomVw)][bottomVw]|"
      ])
  }
}
