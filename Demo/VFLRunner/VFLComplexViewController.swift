//
//  VFLComplexViewController.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit
import VFL

extension VFLComplexViewController {
    class ContentView: UIView {
        private var ctx = VFL()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            let topVw = UIImageView(image: UIImage(named: "square"))
            let leftVw = UIImageView(image: UIImage(named: "square"))
            let rightVw = UIImageView(image: UIImage(named: "square"))
            let borderVw = UIView.create(color: .green)
            ctx.setParent(self).add(
                subviews: [borderVw, topVw, leftVw, rightVw],
                names: ["bVw", "tVw", "lVw", "rVw"]
            )
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
            ctx.replaceConstraints(
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
            ctx.replaceConstraints(
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

        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    }
}

class VFLComplexViewController: UIViewController {
    static func create() -> VFLComplexViewController {
        return VFLComplexViewController(nibName: nil, bundle: nil)
    }
    
    private var ctx = VFL()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Complex Example"
        let vw = ContentView(frame: .zero)
        ctx.setParent(view).add(subviews: [vw], names: ["vw"])
        view.backgroundColor = .white
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        ctx.replaceConstraints(
            metrics: view.safeAreaInsets.metrics,
            formats: [
                "V:|-(top)-[vw]-(bottom)-|",
                "H:|-(left)-[vw]-(right)-|"
            ]
        )
    }
}
