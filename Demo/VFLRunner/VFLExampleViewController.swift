//
//  VFLExampleViewController.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

extension VFLExampleViewController {
    
    class ContentView: UIView {
        init(example: VFLExample, frame: CGRect = .zero) {
            super.init(frame: frame)
            let vws = (0..<example.viewCount).map { _ in UIView.create() }
            VFL(self)
                .addSubviews(vws)
                .appendConstraints(formats: example.formats)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

class VFLExampleViewController: UIViewController {
    let example: VFLExample
    private var ctx = VFL()
    
    init(example: VFLExample) {
        self.example = example
        super.init(nibName: nil, bundle: nil)
        self.title = example.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vw = ContentView(example: example)
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

