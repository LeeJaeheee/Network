//
//  PickLanguageViewController.swift
//  Network
//
//  Created by 이재희 on 1/17/24.
//

import UIKit

class PickLanguageViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let list: [String] = Array(Language.LanguageCode.values).sorted()
    var language: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }

}

extension PickLanguageViewController {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension PickLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell")!
        cell.textLabel?.text = list[indexPath.row]
        cell.selectionStyle = .none
        if list[indexPath.row] == language {
            cell.textLabel?.textColor = .systemGreen
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .systemGreen
        tableView.cellForRow(at: IndexPath(row: list.firstIndex(of: language)!, section: 0))?.textLabel?.textColor = .black
        language = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
        navigationController?.popViewController(animated: true)
    }
}
