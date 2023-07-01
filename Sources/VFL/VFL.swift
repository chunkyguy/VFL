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
  private var parentVw: VFLView?
  
  private var constraints: [NSLayoutConstraint] = [] {
    didSet {
      NSLayoutConstraint.deactivate(oldValue)
      NSLayoutConstraint.activate(constraints)
    }
  }
  
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
  public func appendConstraints(
    options: NSLayoutConstraint.FormatOptions = [],
    metrics: [String: CGFloat]? = nil,
    formats: [String]
  ) -> VFL {
    return updateConstraints(
      overwrite: false,
      options: options,
      metrics: metrics,
      formats: formats
    )
  }
  
  @discardableResult
  public func appendConstraints(_ constraints: [NSLayoutConstraint]) -> VFL {
    return update(constraints: constraints, overwrite: false)
  }
  
  @discardableResult
  public func replaceConstraints(
    options: NSLayoutConstraint.FormatOptions = [],
    metrics: [String: CGFloat]? = nil,
    formats: [String]
  ) -> VFL {
    return updateConstraints(
      overwrite: true,
      options: options,
      metrics: metrics,
      formats: formats
    )
  }
  
  @discardableResult
  public func replaceConstraints(_ constraints: [NSLayoutConstraint]) -> VFL {
    return update(constraints: constraints, overwrite: true)
  }
}

extension VFL {
  private func createConstraints(
    options: NSLayoutConstraint.FormatOptions = [],
    metrics: [String: CGFloat]? = nil,
    formats: [String]
  ) -> [NSLayoutConstraint] {
    return formats.flatMap {
      NSLayoutConstraint.constraints(
        withVisualFormat: $0,
        options: options,
        metrics: metrics,
        views: views
      )
    }
  }
  
  @discardableResult
  private func updateConstraints(
    overwrite: Bool,
    options: NSLayoutConstraint.FormatOptions = [],
    metrics: [String: CGFloat]? = nil,
    formats: [String]
  ) -> VFL {
    update(
      constraints: createConstraints(
        options: options,
        metrics: metrics,
        formats: formats
      ),
      overwrite: overwrite
    )
    return self
  }
  
  @discardableResult
  private func update(constraints: [NSLayoutConstraint], overwrite: Bool) -> VFL {
    if overwrite {
      self.constraints = constraints
    } else {
      self.constraints.append(contentsOf: constraints)
    }
    return self
  }

}
