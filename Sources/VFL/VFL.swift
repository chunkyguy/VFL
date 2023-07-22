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
  private(set) var views: [String: VFLView] = [:]
  private(set) var parentView: VFLView?
  private(set) var constraints: [NSLayoutConstraint] = []
  
  public init(_ view: VFLView? = nil) {
    parentView = view
  }

  @discardableResult
  public func setParent(_ view: VFLView) -> VFL {
    parentView = view
    return self
  }

  @discardableResult
  public func add(subview: VFLView, name: String) -> VFL {
    addSubview(subview)
    subview.translatesAutoresizingMaskIntoConstraints = false
    views[name] = subview
    return self
  }
  
  @discardableResult
  public func addSubview(_ subview: VFLView) -> VFL {
    assert(parentView != nil)
    parentView?.addSubview(subview)
    return self
  }
  
  @discardableResult
  public func appendConstraints(
    options: NSLayoutConstraint.FormatOptions = [],
    metrics: [String: CGFloat]? = nil,
    formats: [String]
  ) -> VFL {
    appendConstraints(formats.flatMap {
      NSLayoutConstraint.constraints(
        withVisualFormat: $0,
        options: options,
        metrics: metrics,
        views: views
      )
    })
    return self
  }
  
  @discardableResult
  public func appendConstraints(_ constraints: [NSLayoutConstraint]) -> VFL {
    NSLayoutConstraint.activate(constraints)
    self.constraints.append(contentsOf: constraints)
    return self
  }

  @discardableResult
  public func removeAllConstraints() -> VFL {
    NSLayoutConstraint.deactivate(self.constraints)
    self.constraints = []
    return self
  }
}
