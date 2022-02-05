//
//  CategoryTableViewController.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 05.10.2021.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = RealmManager()
    let config = ConfigurationForViewController()
    var categoryList: Results<Category>?
    var backColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config.navigationSetup(self, title: "ToDo")
        configTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoryList = realm.loadCategoryItems()
        self.tableView.reloadData()
    }
    
    private func configTableView() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: K.categoryCellIdentifier)
    }
    
    // MARK: - Actions methods
    
    @objc private func addButtonPressed(){
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Shopping list..."
        }
        let closeAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Done", style: .default) { action in
            let textField = alert.textFields?.first
            if let text = textField?.text {
                if text != "" {
                    let newCategory = Category()
                    newCategory.name = text
                    self.realm.save(objects: newCategory, self.tableView)
                }
            }
        }
        alert.addAction(closeAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source and delegate methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellIdentifier, for: indexPath) as? CategoryCell else { return UITableViewCell() }
        if let currentCategory = categoryList?[indexPath.row] {
            cell.todoTextLabel.text = currentCategory.name
            let taskCount = currentCategory.items.count
                cell.tasksCountLabel.text = taskCount != 0 ? "You have \(taskCount) task" : ""
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
                realm.delete(object: currentCategory)
            } else {
                presentUnfinishedTasksAlert()
            }
        }
        tableView.reloadData()
        
    }
    
    private func presentUnfinishedTasksAlert() {
        let alert = UIAlertController(title: "You still have unfinished tasks!", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
