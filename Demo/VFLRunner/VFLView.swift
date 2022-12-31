//
//  VFLView.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

class VFLView: UIView {
    
    init(example: VFLExample, frame: CGRect = .zero) {
        super.init(frame: frame)
        let vws = (0..<example.viewCount).map { _ in UIView.create() }
        addSubviews(vws, constraints: example.constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
