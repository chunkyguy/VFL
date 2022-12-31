//
//  UIView+VFL.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

extension UIView {
    
    /// Add subviews to the receiver
    /// - Parameter subviews: Subviews to be added
    /// - Returns: Context containing the views dictionary
    func addSubviews(_ subviews: [UIView], prefix: String = "vw") -> VFLContext {
        if subviews.isEmpty {
            return VFLContext()
        }
        
        guard subviews.count > 1 else {
            let vw = subviews[0]
            addSubview(vw)
            vw.translatesAutoresizingMaskIntoConstraints = false
            return VFLContext([prefix: vw])
        }
        
        let views = subviews.enumerated().map { (idx, vw) in
            addSubview(vw)
            vw.translatesAutoresizingMaskIntoConstraints = false
            return ("\(prefix)\(idx)", vw)
        }
        return VFLContext(Dictionary(uniqueKeysWithValues: views))
    }
    
    
    // Apply constraints using the context and descriptions
    // Previous contraints in the context are removed and new ones added
    func applyConstraints(
        context: VFLContext,
        options: NSLayoutConstraint.FormatOptions = [],
        metrics: [String: CGFloat]? = nil,
        descriptions: [String]
    ) -> VFLContext {
        return applyConstraints(
            context: context,
            constraints: VFLConstraints(
                options: options,
                metrics: metrics,
                descriptions: descriptions
            )
        )
    }
    
    // Apply constraints using context
    // Previous contraints in the context are removed and new ones added
    func applyConstraints(
        context: VFLContext,
        constraints: VFLConstraints
    ) -> VFLContext {
        let constraints = constraints.descriptions.flatMap { desc in
            NSLayoutConstraint.constraints(
                withVisualFormat: desc,
                options: constraints.options,
                metrics: constraints.metrics,
                views: context.views
            )
        }
        return context.applying(constraints)
    }
    
    // add subviews and apply contraints
    @discardableResult
    func addSubviews(
        _ subviews: [UIView],
        options: NSLayoutConstraint.FormatOptions = [],
        metrics: [String: CGFloat]? = nil,
        descriptions: [String]
    ) -> VFLContext {
        return addSubviews(subviews, constraints: VFLConstraints(
            options: options,
            metrics: metrics,
            descriptions: descriptions
        ))
    }
    
    // add subviews and apply contraints
    @discardableResult
    func addSubviews(
        _ subviews: [UIView],
        constraints: VFLConstraints
    ) -> VFLContext {
        return applyConstraints(
            context: addSubviews(subviews),
            constraints: constraints
        )
    }
}
