//
//  VFLExampleView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit
import WLKit

class VFLExampleView: UIView {
  let title: String
  init(title: String) {
    self.title = title
    super.init(frame: .zero)
    setUp()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setUp() {}
}
