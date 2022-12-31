//
//  VFLConstraints.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

struct VFLConstraints {
    let options: NSLayoutConstraint.FormatOptions
    let metrics: [String: CGFloat]?
    let descriptions: [String]
    
    init(
        options: NSLayoutConstraint.FormatOptions = [],
        metrics: [String : CGFloat]? = nil,
        descriptions: [String]
    ) {
        self.options = options
        self.metrics = metrics
        self.descriptions = descriptions
    }
}
