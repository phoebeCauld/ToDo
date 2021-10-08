//
//  CategoryTableViewController.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 05.10.2021.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    let realm = try! Realm()
    let config = ConfigTableViewController()
    var categoryList: Results<Category>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        config.navigationSetup(self, title: "ToDo")
        tableView.register(CategoryCell.self, forCellReuseIdentifier: K.categoryCellIdentifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
    }

    // MARK: - Table view data source and delegate methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellIdentifier, for: indexPath) as! CategoryCell
        cell.todoTextLabel.text = categoryList?[indexPath.row].name ?? "dont have categories yet"
        if let taskCount = categoryList?[indexPath.row].items.count {
            if taskCount != 0 {
            cell.tasksCountLabel.text = "You have \(taskCount) task"
            } else {
                cell.tasksCountLabel.text = ""
            }
        } 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tasksVC = TodoListViewController()
        tasksVC.selectedCategory = categoryList?[indexPath.row]
        navigationController?.pushViewController(tasksVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let currentCategory = categoryList?[indexPath.row] {
            if currentCategory.items.count  == 0 {
                delete(item: currentCategory)
            } else {
                let alert = UIAlertController(title: "You still have unfinished tasks!", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
        tableView.reloadData()
        
    }

    // MARK: - Actions methods
    
    @objc func addButtonPressed(){
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Shopping list..."
        }
        let action = UIAlertAction(title: "Done", style: .default) { action in
            let textField = alert.textFields?.first
            if let text = textField?.text {
                if text != "" {
                    let newCategory = Category()
                    newCategory.name = text
                    self.save(category: newCategory)
                }
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Load, Save and Delete methods
    
    func save(category: Category){
        do {
            try realm.write{
                realm.add(category)
            }
        } catch let error as NSError {
            print("failed with save category: \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    
    func loadItems(){
        categoryList = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    func delete(item: Category){
        do {
            try realm.write{
                realm.delete(item)
            }
        } catch let error as NSError {
            print("error saving data \(error.localizedDescription)")
        }
    }


}
