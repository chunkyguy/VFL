//
//  VFLSubAlignView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 22/07/2023.
//

import UIKit
import WLKit

// Many subviews that align themselves based on NSLayoutConstraint.FormatOptions
class VFLSubAlignView: VFLExampleView {
  
  private var selectedVw: AlignView? {
    didSet {
      oldValue?.setSelection(false)
      selectedVw?.setSelection(true)
    }
  }

  override func setUp() {
    super.setUp()
    let contentVw = ContentView(title: "Content")
    let controlVw = ControlView()
    VFL(self)
      .add(subview: contentVw, name: "contentVw")
      .add(subview: controlVw, name: "controlVw")
      .appendConstraints(formats: [
        "H:|[contentVw]|",
        "H:|[controlVw]|",
        "V:|[contentVw][controlVw(100)]|"
      ])
    
    controlVw.onTap = { [weak self, weak contentVw] alignment, alignVw in
      self?.selectedVw = alignVw
      contentVw?.setAlignment(alignment: alignment)
    }
  }
}

private extension VFLSubAlignView {
  class ContentView: VFLExampleView {
    let vfl = VFL()

    override func setUp() {
      super.setUp()
      vfl
        .setParent(self)
        .add(subview: VFLColorView(color: .random), name: "redVw")
        .add(subview: VFLColorView(color: .random), name: "blueVw")
        .add(subview: VFLColorView(color: .random), name: "greenVw")
        .storeConstraints(
          formats: [
            "H:|[redVw(30)][blueVw(60)][greenVw(90)]",
            "V:|-(>=100)-[redVw(30)]",
            "V:|-(>=100)-[blueVw(60)]",
            "V:|-(>=100)-[greenVw(90)]"
          ],
          name: "h_layout"
        )
        .storeConstraints(
          formats: [
            "H:|-(>=100)-[redVw(30)]",
            "H:|-(>=100)-[blueVw(60)]",
            "H:|-(>=100)-[greenVw(90)]",
            "V:|[redVw(30)][blueVw(60)][greenVw(90)]"
          ],
          name: "v_layout"
        )
        .applyConstraints(name: "h_layout")
    }
    
    func setAlignment(alignment: NSLayoutConstraint.FormatOptions) {
      let vLayouts: NSLayoutConstraint.FormatOptions = [
        .alignAllLeft, .alignAllCenterX, .alignAllRight
      ]
      let constraintsName = vLayouts.contains(alignment) ? "v_layout" : "h_layout"
      vfl
        .removeAllConstraints()
        .removeAllOptions()
        .addOptions(alignment)
        .applyConstraints(name: constraintsName)
      
      UIView.animate(withDuration: 0.2) {
        self.vfl.parentView?.layoutIfNeeded()
      }
    }
  }
  
  class ControlView: UIView {
    var onTap: AlignViewAction? {
      didSet {
        contentVwVFL.views.values.forEach { view in
          (view as? AlignView)?.onTap = onTap
        }
      }
    }
    
    let contentVwVFL = VFL()

    override init(frame: CGRect) {
      super.init(frame: frame)
      
      let contentVw = UIView()
      
      VFL(self)
        .add(subview: contentVw, name: "contentVw")
        .appendConstraints([
          contentVw.centerXAnchor.constraint(equalTo: self.centerXAnchor),
          contentVw.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
      
      contentVwVFL
        .setParent(contentVw)
        .add(subview: AlignView(alignment: .alignAllLeft), name: "alignLeftVw")
        .add(subview: AlignView(alignment: .alignAllCenterX), name: "alignCenterXVw")
        .add(subview: AlignView(alignment: .alignAllRight), name: "alignRightVw")
        .add(subview: AlignView(alignment: .alignAllTop), name: "alignTopVw")
        .add(subview: AlignView(alignment: .alignAllCenterY), name: "alignCenterYVw")
        .add(subview: AlignView(alignment: .alignAllBottom), name: "alignBottomVw")
        .addMetrics(["size": 40])
        .applyConstraints(formats: [
          "H:|[alignLeftVw(size)]-[alignCenterXVw(size)]-[alignRightVw(size)]-[alignTopVw(size)]-[alignCenterYVw(size)]-[alignBottomVw(size)]|",
          "V:|[alignLeftVw(size)]|",
          "V:|[alignCenterXVw(size)]|",
          "V:|[alignRightVw(size)]|",
          "V:|[alignTopVw(size)]|",
          "V:|[alignCenterYVw(size)]|",
          "V:|[alignBottomVw(size)]|"
        ])
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }
  
  typealias AlignViewAction = (NSLayoutConstraint.FormatOptions, AlignView) -> Void
  
  class AlignView: UIView {
    let alignment: NSLayoutConstraint.FormatOptions
    var onTap: AlignViewAction?
    private let button = UIButton()

    init(alignment: NSLayoutConstraint.FormatOptions) {
      self.alignment = alignment
      super.init(frame: .zero)
      let imageName: String
      if alignment == .alignAllLeft {
        imageName = "align.horizontal.left"
      }
      else if alignment == .alignAllCenterX {
        imageName = "align.horizontal.center"
      }
      else if alignment == .alignAllRight {
        imageName = "align.horizontal.right"
      }
      else if alignment == .alignAllTop {
        imageName = "align.vertical.top"
      }
      else if alignment == .alignAllCenterY {
        imageName = "align.vertical.center"
      }
      else if alignment == .alignAllBottom {
        imageName = "align.vertical.bottom"
      }
      else {
        imageName = "align.horizontal.left"
      }
      
      VFL(self)
        .add(subview: button, name: "button")
        .appendConstraints(formats: ["H:|[button]|", "V:|[button]|"])
      
      button.setImage(UIImage(systemName: imageName), for: .normal)
      button.setImage(UIImage(systemName: "\(imageName).fill"), for: .selected)
      button.setImage(UIImage(systemName: "\(imageName).fill"), for: .highlighted)
      button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func setSelection(_ isSelected: Bool) {
      button.isSelected = isSelected
    }
    
    @objc func handleTap(_ sender: UIButton) {
      onTap?(alignment, self)
    }
  }
}
