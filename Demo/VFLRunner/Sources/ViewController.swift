//
//  ViewController.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import UIKit
import VFL

enum VFLExamples: String, CaseIterable {
  case full = "Screen Full Layout"
  case hsplit = "Horizontal Equal Split"
  case vsplit = "Vertical Equal Split"
  case fixed = "Fixed Size View"
  case complex = "Complex Example"
  
  var view: VFLExampleView {
    switch self {
    case .full:
      return VFLFullView(title: rawValue)
    case .hsplit:
      return VFLHSplitView(title: rawValue)
    case .vsplit:
      return VFLVSplitView(title: rawValue)
    case .fixed:
      return VFLFixView(title: rawValue)
    case .complex:
      return VFLComplexView(title: rawValue)
    }
  }
}

class ViewController: UIViewController {
  static let cellId = "cell-id"
  
  lazy var vfl = VFL(view)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "VFL Demo"
    
    let tableVw = UITableView(frame: .zero, style: .plain)
    vfl
      .add(subview: tableVw, name: "tableVw")
    tableVw.dataSource = self
    tableVw.delegate = self
    tableVw.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellId)
  }
  
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    vfl
      .replaceConstraints(
        metrics: view.safeAreaInsets.metrics,
        formats: [
          "V:|-(top)-[tableVw]-(bottom)-|",
          "H:|-(left)-[tableVw]-(right)-|"
        ])
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return VFLExamples.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellId, for: indexPath)
    cell.textLabel?.text = VFLExamples.allCases[indexPath.row].rawValue
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let example = VFLExamples.allCases[indexPath.row]
    let vwCtrl = VFLViewController(contentView: example.view, title: example.rawValue)
    navigationController?.pushViewController(vwCtrl, animated: true)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
