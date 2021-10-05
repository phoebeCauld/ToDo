//
//  ConfigView.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 02.10.2021.
//

import UIKit

struct ConfigTableViewController {
    
    let searchField: UISearchController = {
       let sb = UISearchController(searchResultsController: nil)
        sb.searchBar.searchBarStyle = .prominent
        sb.searchBar.placeholder = " Search..."
        sb.searchBar.sizeToFit()
        sb.searchBar.searchTextField.backgroundColor = .white
        return sb
    }()
    
    func navigationSetup(_ tableView: UITableViewController){
        tableView.view.backgroundColor = .white
        tableView.navigationItem.searchController = searchField
        searchField.hidesNavigationBarDuringPresentation = false
        searchField.obscuresBackgroundDuringPresentation = false
        tableView.navigationItem.hidesSearchBarWhenScrolling = false
        
        tableView.navigationItem.title = "ToDo"
        tableView.navigationController?.navigationBar.barTintColor = .systemBlue
        tableView.navigationController?.navigationBar.tintColor = .white
        tableView.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .black), NSAttributedString.Key.foregroundColor: UIColor.white]
    }


}
