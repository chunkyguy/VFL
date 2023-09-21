//
//  VFLViewController.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit
import WLKit

class VFLViewController: UIViewController {
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
    VFL(view)
      .add(subview: WLSafeAreaView(contentView), name: "contentVw")
      .applyConstraints(formats: ["V:|[contentVw]|","H:|[contentVw]|"])
    
    view.backgroundColor = .white
  }  
}
