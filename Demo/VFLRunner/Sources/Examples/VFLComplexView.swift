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
    private let vfl = VFL()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      let headerVw = UIImageView(image: UIImage(named: "square"))
      let borderVw = VFLColorView(color: .green)
      let firstThumbVw = UIImageView(image: UIImage(named: "square"))
      let secondThumbVw = UIImageView(image: UIImage(named: "square"))
      vfl
          .setParent(self)
          .add(subview: headerVw, name: "headerVw")
          .add(subview: borderVw, name: "borderVw")
          .add(subview: firstThumbVw, name: "firstThumbVw")
          .add(subview: secondThumbVw, name: "secondThumbVw")
          .addMetrics(["w": 0, "hw": 0])
          .storeConstraints(
            formats: [
              "H:|[headerVw]|",
              "H:|[borderVw]|",
              "H:|-[firstThumbVw(==secondThumbVw)]-[secondThumbVw]-|",
              "V:|[headerVw(w)][borderVw(40)]",
              "V:[firstThumbVw(hw)]|", "V:[secondThumbVw(hw)]|"
            ],
            name: "portrait"
          )
          .storeConstraints(
            formats: [
              "H:|[headerVw(w)][borderVw(40)]",
              "H:[firstThumbVw(hw)]|", "H:[secondThumbVw(hw)]|",
              "V:|[headerVw]|",
              "V:|[borderVw]|",
              "V:|-[firstThumbVw(==secondThumbVw)]-[secondThumbVw]-|",
            ],
            name: "landscape"
          )
          .applyConstraints(name: "portrait")
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
      vfl
        .removeAll()
        .addMetrics(["w": bounds.width, "hw": bounds.width * 0.5])
        .applyConstraints(name: "portrait")
    }
    
    private func layoutSubviewLandscape() {
      vfl
        .removeAll()
        .addMetrics(["w": bounds.height, "hw": bounds.height * 0.5])
        .applyConstraints(name: "landscape")
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }
}
