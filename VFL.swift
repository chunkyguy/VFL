//
//  VFL.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

struct VFLContext {
    let views: [String: UIView]
    let constraints: [NSLayoutConstraint]

    private init(views: [String : UIView], constraints: [NSLayoutConstraint]) {
        self.views = views
        self.constraints = constraints
    }
    
    init(_ views: [String: UIView] = [:]) {
        self.init(views: views, constraints: [])
    }
    
    func applying(_ constraints: [NSLayoutConstraint]) -> VFLContext {
        NSLayoutConstraint.deactivate(self.constraints)
        NSLayoutConstraint.activate(constraints)
        return VFLContext(views: self.views, constraints: constraints)
    }
}

struct VFLDescription {
    let options: NSLayoutConstraint.FormatOptions
    let metrics: [String: CGFloat]?
    let formats: [String]
    
    init(
        options: NSLayoutConstraint.FormatOptions = [],
        metrics: [String : CGFloat]? = nil,
        formats: [String]
    ) {
        self.options = options
        self.metrics = metrics
        self.formats = formats
    }
}

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
        formats: [String]
    ) -> VFLContext {
        return applyConstraints(
            context: context,
            constraints: VFLDescription(
                options: options,
                metrics: metrics,
                formats: formats
            )
        )
    }
    
    // Apply constraints using context
    // Previous contraints in the context are removed and new ones added
    func applyConstraints(
        context: VFLContext,
        constraints: VFLDescription
    ) -> VFLContext {
        let constraints = constraints.formats.flatMap { desc in
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
        formats: [String]
    ) -> VFLContext {
        return addSubviews(
            subviews,
            description: VFLDescription(
                options: options,
                metrics: metrics,
                formats: formats
            )
        )
    }
    
    // add subviews and apply contraints
    @discardableResult
    func addSubviews(
        _ subviews: [UIView],
        description: VFLDescription) -> VFLContext {
        return applyConstraints(
            context: addSubviews(subviews),
            constraints: description
        )
    }
}

extension UIEdgeInsets {
    var metrics: [String: CGFloat] {
        return [
            "top": self.top,
            "bottom": self.bottom,
            "left": self.left,
            "right": self.right
        ]
    }
}
