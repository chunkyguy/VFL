//
//  VFLExamplesViewController.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

class VFLExamplesViewController: UIViewController {

    static func create() -> VFLExamplesViewController {
        return VFLExamplesViewController(nibName: nil, bundle: nil)
    }
    
    static let cellId = "cell-id"
    
    private var ctx = VFL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Basic Examples"
        view.backgroundColor = .white

        let tableVw = UITableView(frame: .zero, style: .plain)
        ctx.setParent(view).add(subviews: [tableVw], names: ["vw"])
        tableVw.dataSource = self
        tableVw.delegate = self
        tableVw.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellId)
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

extension VFLExamplesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VFLExamples.all.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellId, for: indexPath)
        cell.textLabel?.text = VFLExamples.all[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension VFLExamplesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vwCtrl = VFLExampleViewController(example: VFLExamples.all[indexPath.row])
        navigationController?.pushViewController(vwCtrl, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


class FooView: UIView {
    
    
    func foo() {
        
        let imageView = UIImageView(frame: .zero)
        let label = UIView()
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        let flexibleButton = UIButton()
        
        NSLayoutConstraint.activate([
            flexibleButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 70),
            flexibleButton.widthAnchor.constraint(lessThanOrEqualToConstant: 100)
        ])
        
        let constraints = ["V:|[imgVw][label]|", "H:|[imgVw]|", "H:|[label]|"].flatMap {
            NSLayoutConstraint.constraints(
                withVisualFormat: $0,
                metrics: nil, views: ["imgVw": imageView]
            )
        }
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
}
