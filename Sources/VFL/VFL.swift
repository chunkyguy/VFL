//
//  VFL.swift
//  Created by Sidharth Juyal on 31/12/2022.
//
#if os(macOS)
import AppKit
public typealias VFLView = NSView
#else
import UIKit
public typealias VFLView = UIView
#endif

public class VFL {
    private var views: [String: VFLView] = [:]
    private var constraints: [NSLayoutConstraint] = []
    private var parentVw: VFLView?
    
    public init(_ view: VFLView? = nil) {
        parentVw = view
    }
    
    @discardableResult
    public func setParent(_ view: VFLView) -> VFL {
        parentVw = view
        return self
    }
    
    @discardableResult
    public func add(subview: VFLView, name: String) -> VFL {
        assert(parentVw != nil)
        parentVw?.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        views[name] = subview
        return self
    }

    @discardableResult
    public func add(subviews: [VFLView], names: [String]) -> VFL {
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
        subviews: [VFLView]
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
        subviews: [VFLView]
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
        subviews: [VFLView]
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
