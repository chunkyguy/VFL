//
//  ViewController.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit

class ViewController: UIViewController {
    static let cellId = "cell-id"
    
    private var ctx = VFLContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "VFL Examples"

        let tableVw = UITableView(frame: .zero, style: .plain)
        ctx = view.addSubviews([tableVw])
        tableVw.dataSource = self
        tableVw.delegate = self
        tableVw.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellId)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        ctx = view.applyConstraints(
            context: ctx,
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
        return VFLExamples.all.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellId, for: indexPath)
        cell.textLabel?.text = VFLExamples.all[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vwCtrl = VFLViewController(example: VFLExamples.all[indexPath.row])
        navigationController?.pushViewController(vwCtrl, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
