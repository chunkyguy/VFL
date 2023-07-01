//
//  VFLComplexView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 01/07/2023.
//

import UIKit
import VFL

class VFLComplexView: VFLExampleView {
  override func setUp() {
    super.setUp()
    VFL(self)
      .add(subview: ContentView(frame: .zero), name: "contentVw")
      .appendConstraints(
        metrics: [
          "top": 32, "bottom": 32,
          "left": 16, "right": 16
        ],
        formats: [
          "V:|-(top)-[contentVw]-(bottom)-|",
          "H:|-(left)-[contentVw]-(right)-|"
        ])
    
    backgroundColor = .white
  }
}

extension VFLComplexView {
  class ContentView: UIView {
    private var vfl = VFL()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      let topVw = UIImageView(image: UIImage(named: "square"))
      let leftVw = UIImageView(image: UIImage(named: "square"))
      let rightVw = UIImageView(image: UIImage(named: "square"))
      let borderVw = VFLColorView(color: .green)
      vfl
        .setParent(self)
        .add(subview: borderVw, name: "bVw")
        .add(subview: topVw, name: "tVw")
        .add(subview: leftVw, name: "lVw")
        .add(subview: rightVw, name: "rVw")
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
      if bounds.width < bounds.height {
        layoutSubviewPortrait()
      } else {
        layoutSubviewLandscape()
      }
    }
    
    private func layoutSubviewPortrait() {
      vfl.replaceConstraints(
        metrics: [
          "w": bounds.width,
          "hw": bounds.width / 2
        ],
        formats: [
          "V:|[tVw(w)][bVw(40)]",
          "H:|[tVw]|",
          "H:|[bVw]|",
          "V:[lVw(hw)]|",
          "V:[rVw(hw)]|",
          "H:|-[lVw(==rVw)]-[rVw]-|"
        ]
      )
    }
    
    private func layoutSubviewLandscape() {
      vfl.replaceConstraints(
        metrics: [
          "w": bounds.height,
          "hw": bounds.height / 2.0,
        ],
        formats: [
          "V:|[tVw]|",
          "H:|[tVw(w)][bVw(40)]",
          "V:|[bVw]|",
          "V:|-[lVw(==rVw)]-[rVw]-|",
          "H:[lVw(hw)]|",
          "H:[rVw(hw)]|",
        ]
      )
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }
}
