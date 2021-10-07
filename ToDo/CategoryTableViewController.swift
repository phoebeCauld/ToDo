//
//  CategoryTableViewController.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 05.10.2021.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    let config = ConfigTableViewController()
    var categoryList = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        return categoryList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellIdentifier, for: indexPath) as! CategoryCell
        cell.todoTextLabel.text = categoryList[indexPath.row].name
        if let taskCount = categoryList[indexPath.row].items?.count {
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
        tasksVC.selectedCategory = categoryList[indexPath.row]
        navigationController?.pushViewController(tasksVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if categoryList[indexPath.row].items?.count == 0 {
            context.delete(categoryList[indexPath.row])
            categoryList.remove(at: indexPath.row)
            saveItems()
        } else {
            let alert = UIAlertController(title: "You still have unfinished tasks!", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
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
                    let newCategory = Category(context: self.context)
                    newCategory.name = text
                    self.categoryList.append(newCategory)
                    self.saveItems()
                } else {
                    print("empty field")
                }
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - CoreData methods
    
    func saveItems(){
        do {
            try context.save()
        } catch let error as NSError {
            print("failed with save category: \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        do {
            categoryList =  try context.fetch(request)
        } catch let error as NSError {
            print("failed with loading data: \(error.localizedDescription)")
        }
        tableView.reloadData()
    }

    // MARK: - Navigation


}
