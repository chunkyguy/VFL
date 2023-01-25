//
//  VFL.swift
//  Created by Sidharth Juyal on 31/12/2022.
//
#if os(iOS)
import UIKit

public class VFL {
    private var views: [String: UIView] = [:]
    private var constraints: [NSLayoutConstraint] = []
    private var parentVw: UIView?
    
    public init(_ view: UIView? = nil) {
        parentVw = view
    }
    
    @discardableResult
    public func setParent(_ view: UIView) -> VFL {
        parentVw = view
        return self
    }
    
    @discardableResult
    public func add(subview: UIView, name: String) -> VFL {
        assert(parentVw != nil)
        parentVw?.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        views[name] = subview
        return self
    }

    @discardableResult
    public func add(subviews: [UIView], names: [String]) -> VFL {
        (0..<subviews.count).forEach { idx in
            add(subview: subviews[idx], name: names[idx])
        }
        return self
    }
    
    @discardableResult
    public func appendConstraints(
        options: NSLayoutConstraint.FormatOptions = [],
        metrics: [String: CGFloat]? = nil,
        formats: [String]
    ) -> VFL {
        appendConstraints(
            getConstraints(
                options: options,
                metrics: metrics,
                formats: formats
            )
        )
        return self
    }
    
    @discardableResult
    public func replaceConstraints(
        options: NSLayoutConstraint.FormatOptions = [],
        metrics: [String: CGFloat]? = nil,
        formats: [String]
    ) -> VFL {
        replaceConstraints(
            getConstraints(
                options: options,
                metrics: metrics,
                formats: formats
            )
        )
        return self
    }
    
    @discardableResult
    public func appendConstraints(
        attributes: [NSLayoutConstraint.Attribute: CGFloat],
        subviews: [UIView]
    ) -> VFL {
        appendConstraints(getConstraints(
            attributes: attributes,
            subviews: subviews
        ))
        return self
    }
    
    @discardableResult
    public func replaceConstraints(
        attributes: [NSLayoutConstraint.Attribute: CGFloat],
        subviews: [UIView]
    ) -> VFL {
        replaceConstraints(getConstraints(
            attributes: attributes,
            subviews: subviews
        ))
        return self
    }
}

extension VFL {
    public func getConstraints(
        attributes: [NSLayoutConstraint.Attribute: CGFloat],
        subviews: [UIView]
    ) -> [NSLayoutConstraint] {
        guard let item = parentVw else { return [] }
        return attributes.flatMap { (attr, constant) in
            subviews.map { subview in
                NSLayoutConstraint(
                    item: item,
                    attribute: attr,
                    relatedBy: .equal,
                    toItem: subview,
                    attribute: attr,
                    multiplier: 1,
                    constant: constant
                )
            }
        }
    }
    
    private func getConstraints(
        options: NSLayoutConstraint.FormatOptions = [],
        metrics: [String: CGFloat]? = nil,
        formats: [String]
    ) -> [NSLayoutConstraint] {
        return formats.flatMap { desc in
            NSLayoutConstraint.constraints(
                withVisualFormat: desc,
                options: options,
                metrics: metrics,
                views: views
            )
        }
    }

    private func appendConstraints(_ constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constraints)
        self.constraints.append(contentsOf: constraints)
    }
    
    private func replaceConstraints(_ constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.deactivate(self.constraints)
        NSLayoutConstraint.activate(constraints)
        self.constraints = constraints
    }
}

extension UIEdgeInsets {
    public var metrics: [String: CGFloat] {
        return [
            "top": self.top,
            "bottom": self.bottom,
            "left": self.left,
            "right": self.right
        ]
    }
}
#endif
