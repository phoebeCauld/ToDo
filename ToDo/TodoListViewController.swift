//
//  ViewController.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 02.10.2021.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var configTV = ConfigTableViewController()
    let defaults = UserDefaults()
    var list = ["cook", "clean", "eat", "game"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cellIdentifier)
        configTV.navigationSetup(self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        if let items = defaults.array(forKey: K.defaultsKey) as? [String] {
            list = items
        }
    }
    
    
    @objc func addButtonPressed(){
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Make a dinner..."
        }
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let textField = alert.textFields?.first
            if let newTask = textField?.text {
                if newTask != "" {
                    self.list.append(newTask)
                    self.defaults.set(self.list, forKey: K.defaultsKey)
                    self.tableView.reloadData()
                }else {
                    print("empty text")
                }
            }
        } 
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
    }
    
    
}

