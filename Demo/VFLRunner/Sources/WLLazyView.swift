//
//  WLLazyView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 22/07/2023.
//

import UIKit

class WLLazyView: UIView {
  private var isSetUp = false
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if !isSetUp {
      isSetUp = true
      setUp()
    }
  }
  
  func setUp() {}
}
