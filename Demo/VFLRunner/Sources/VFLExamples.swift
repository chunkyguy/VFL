//
//  VFLExamples.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 01/07/2023.
//

import Foundation

enum VFLExamples: String, CaseIterable {
  case full = "Screen Full Layout"
  case hsplit = "Horizontal Equal Split"
  case vsplit = "Vertical Equal Split"
  case fixed = "Fixed Size View"
  case center = "Center View"
  case complex = "Complex Example"
  
  var view: VFLExampleView {
    switch self {
    case .full:
      return VFLFullView(title: rawValue)
    case .hsplit:
      return VFLHSplitView(title: rawValue)
    case .vsplit:
      return VFLVSplitView(title: rawValue)
    case .fixed:
      return VFLFixView(title: rawValue)
    case .center:
      return VFLCenterView(title: rawValue)
    case .complex:
      return VFLComplexView(title: rawValue)
    }
  }
}
