//
//  ViewController.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 02.10.2021.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    let realm = RealmManager()
    var toDoItems: Results<Item>?
    private var configTV = ConfigurationForViewController()
    var selectedCategory: Category? {
        didSet{
            toDoItems = self.realm.loadTaskItems(selectedCategory)
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TaskCell.self, forCellReuseIdentifier: K.cellIdentifier)
        configTV.navigationSetup(self, title: selectedCategory?.name ?? "Tasks")
        configTV.searchSetup(self)
        configTV.searchField.searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let toDoItems = toDoItems else { return }
        for item in toDoItems {
            if item.done {
                realm.delete(object: item)
            }
        }
    }
    
    //MARK: - Actions methods
    @objc func addButtonPressed(){
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Make a dinner..."
        }
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let textField = alert.textFields?.first
            if let newTask = textField?.text {
                if newTask != "" {
                    if let currentCategory = self.selectedCategory {
                        do {
                            try self.realm.realm?.write{
                                let newItem = Item()
                                newItem.title = newTask
                                newItem.dateCreated = Date()
                                currentCategory.items.append(newItem)
                            }
                        } catch {
                            print("error saving data \(error.localizedDescription)")
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
        let closeAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(closeAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - DataSourse and Delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! TaskCell
        if let item = toDoItems?[indexPath.row] {
            cell.todoTextLabel.text = item.title
            cell.checkMark.image = item.done ? UIImage(systemName: K.Images.doneMark)?.withTintColor(.black, renderingMode: .alwaysOriginal) : UIImage(systemName: K.Images.circle)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let currentItem = toDoItems?[indexPath.row]{
            do {
                try realm.realm?.write{
                    currentItem.done = !currentItem.done
                }
            } catch {
                print("Faild with saving done status \(error.localizedDescription)")
            }
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let selectedItem = toDoItems?[indexPath.row] {
            realm.delete(object: selectedItem)
        }
        tableView.reloadData()
    }
}




