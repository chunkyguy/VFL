//
//  ViewController.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit
import VFL

class ViewController: UIViewController {
    static let cellId = "cell-id"
    
    private let vfl = VFL()
    
    private let demoList: [(name: String, vwCtrl: () -> UIViewController )] = [
        (name: "Basic Examples", vwCtrl: { VFLExamplesViewController.create() }),
        (name: "Complex Example", vwCtrl: { VFLComplexViewController.create() })
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "VFL Demo"

        let tableVw = UITableView(frame: .zero, style: .plain)
        vfl.setParent(view).add(subviews: [tableVw], names: ["vw"])
        tableVw.dataSource = self
        tableVw.delegate = self
        tableVw.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellId)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        vfl.replaceConstraints(
            metrics: view.safeAreaInsets.metrics,
            formats: [
                "V:|-(top)-[vw]-(bottom)-|",
                "H:|-(left)-[vw]-(right)-|"
            ]
        )
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellId, for: indexPath)
        cell.textLabel?.text = demoList[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vwCtrl = demoList[indexPath.row].vwCtrl()
        navigationController?.pushViewController(vwCtrl, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
