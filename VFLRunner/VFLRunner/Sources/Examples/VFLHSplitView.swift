//
//  VFLHSplitView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 01/07/2023.
//

import UIKit
import WLKit

// Add two subviews of equal width and same height as parent
class VFLHSplitView: VFLExampleView {
  override func setUp() {
    super.setUp()
    VFL(self)
      .add(subview: VFLColorView(), name: "leftVw")
      .add(subview: VFLColorView(), name: "rightVw")
      .appendConstraints(formats: [
        "V:|[leftVw]|", "V:|[rightVw]|",
        "H:|[leftVw(==rightVw)][rightVw]|"
      ])
  }
}
