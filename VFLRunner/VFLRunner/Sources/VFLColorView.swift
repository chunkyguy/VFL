//
//  VFLColorView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 01/07/2023.
//

import UIKit

class VFLColorView: UIView {
  init(color: UIColor = .random) {
    super.init(frame: .zero)
    backgroundColor = color
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
