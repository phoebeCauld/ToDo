//
//  ViewController.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 02.10.2021.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController {

    var configTV = ConfigTableViewController()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var list = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cellIdentifier)
        configTV.navigationSetup(self)
        configTV.searchField.searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
        loadItems()
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
                    let newItem = Item(context: self.context)
                    newItem.title = newTask
                    newItem.done = false
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
    
//MARK: - Save items method
    func saveItem(){
        do {
            try context.save()
        } catch let error as NSError {
            print("error saving data \(error.localizedDescription)")
        }
    }
//MARK: - Load items method
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        do {
            list = try context.fetch(request)
        } catch let error as NSError {
            print("error fetching data from context \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
//MARK: - DataSourse and Delegate methods
    
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




