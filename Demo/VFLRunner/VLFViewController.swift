//
//  VLFViewController.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

class VFLViewController: UIViewController {
    let example: VFLExample
    private var ctx = VFLContext()
    
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
        let vw = VFLView(example: example)
        ctx = view.addSubviews([vw])
        view.backgroundColor = .white
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        ctx = view.applyConstraints(
            context: ctx,
            metrics: view.safeAreaInsets.metrics,
            descriptions: [
                "V:|-(top)-[vw]-(bottom)-|",
                "H:|-(left)-[vw]-(right)-|"
            ]
        )
    }
}

