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
    var timer = Timer()
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TaskCell.self, forCellReuseIdentifier: K.cellIdentifier)
        configTV.navigationSetup(self, title: selectedCategory!.name!)
        configTV.searchSetup(self)
        configTV.searchField.searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for item in list {
            if item.done {
                context.delete(item)
                saveItem()
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
                    let newItem = Item(context: self.context)
                    newItem.title = newTask
                    newItem.done = false
                    newItem.parentCategory = self.selectedCategory
                    self.list.append(newItem)
                    self.saveItem()
                    self.tableView.reloadData()
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
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        guard let categoryName = selectedCategory?.name else { return }
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", categoryName)
        if let additionalPredicate = predicate {
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
            request.predicate = compoundPredicate
        } else {
            request.predicate = categoryPredicate
        }   
        do {
            list = try context.fetch(request)
        } catch let error as NSError {
            print("error loading data from context \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
//MARK: - DataSourse and Delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! TaskCell
        let item = list[indexPath.row]
        cell.todoTextLabel.text = item.title
        if item.done {
            cell.checkMark.image = UIImage(systemName: K.Images.doneMark)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        } else {
            cell.checkMark.image = UIImage(systemName: K.Images.circle)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        }
                
//        cell.checkMark.isHidden = item.done ? false : true
//        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentItem = list[indexPath.row]
        currentItem.done = !currentItem.done
        saveItem()
        tableView.reloadData()
    }
    
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        context.delete(list[indexPath.row])
//        list.remove(at: indexPath.row)
//        saveItem()
//    }
}




