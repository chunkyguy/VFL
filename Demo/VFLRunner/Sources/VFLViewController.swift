//
//  VFLViewController.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit
import VFL

class VFLViewController: UIViewController {
  private lazy var vfl = VFL(view)
  private let contentView: UIView
  
  init(contentView: UIView, title: String) {
    self.contentView = contentView
    super.init(nibName: nil, bundle: nil)
    self.title = title
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    vfl
      .add(subview: contentView, name: "contentVw")
      .addMetrics(view.safeAreaInsets.metrics)
      .storeConstraints(
        formats: [
          "V:|-(top)-[contentVw]-(bottom)-|",
          "H:|-(left)-[contentVw]-(right)-|"
        ],
        name: "constraints"
      )
      .applyConstraints(name: "constraints")
    
    view.backgroundColor = .white
  }
  
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    vfl
      .removeAll()
      .addMetrics(view.safeAreaInsets.metrics)
      .applyConstraints(name: "constraints")
  }
}
