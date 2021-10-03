//
//  ViewController.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 02.10.2021.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var configTV = ConfigTableViewController()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first?.appendingPathComponent("Item.plist")
    var list = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cellIdentifier)
        configTV.navigationSetup(self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        loadItems()
    }
    
// Actions methods
    @objc func addButtonPressed(){
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Make a dinner..."
        }
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let textField = alert.textFields?.first
            if let newTask = textField?.text {
                if newTask != "" {
                    let newItem = Item()
                    newItem.title = newTask
                    self.list.append(newItem)
                    self.saveItem()
                    self.tableView.reloadData()
                }else {
                    print("empty text")
                }
            }
        } 
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
// Save items method
    func saveItem(){
        let encoder = PropertyListEncoder()
        do {
            let data =  try encoder.encode(list)
            if let dataPath = dataFilePath {
                try data.write(to: dataPath)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func loadItems(){
        let decoder = PropertyListDecoder()
        if let dataPath = dataFilePath{
            do {
                let data = try Data(contentsOf: dataPath)
                list = try decoder.decode([Item].self, from: data)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
// DataSourse and Delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        let item = list[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        list[indexPath.row].done = !list[indexPath.row].done
        saveItem()
        tableView.reloadData()
    }
}

