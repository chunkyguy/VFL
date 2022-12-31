//
//  VFLContext.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

struct VFLContext {
    let views: [String: UIView]
    let constraints: [NSLayoutConstraint]

    private init(
        views: [String : UIView],
        constraints: [NSLayoutConstraint]
    ) {
        self.views = views
        self.constraints = constraints
    }
    
    init(_ views: [String: UIView] = [:]) {
        self.init(views: views, constraints: [])
    }
    
    func applying(_ constraints: [NSLayoutConstraint]) -> VFLContext {
        NSLayoutConstraint.deactivate(self.constraints)
        NSLayoutConstraint.activate(constraints)
        return VFLContext(
            views: self.views,
            constraints: constraints
        )
    }
}
