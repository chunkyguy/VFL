//
//  WLSafeAreaView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 21/09/2023.
//

import UIKit
import WLKit

class WLSafeAreaView: UIView {
  let contentView: UIView
  private let vfl = VFL()

  init(_ contentView: UIView = UIView()) {
    self.contentView = contentView
    super.init(frame: .zero)
    vfl
      .setParent(self)
      .add(subview: contentView, name: "contentView")
      .addMetrics(safeAreaInsets.metrics)
      .storeConstraints(
        formats: [
          "V:|-(top)-[contentView]-(bottom)-|",
          "H:|-(left)-[contentView]-(right)-|"
        ],
        name: "constraints"
      )
      .applyConstraints(name: "constraints")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func safeAreaInsetsDidChange() {
    super.safeAreaInsetsDidChange()
    vfl
      .removeAll()
      .addMetrics(safeAreaInsets.metrics)
      .applyConstraints(name: "constraints")
  }
}
