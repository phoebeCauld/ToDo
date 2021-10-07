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
        sb.searchBar.searchTextField.backgroundColor = .clear
        return sb
    }()
    
    func searchSetup(_ tableView: UITableViewController){
        tableView.navigationItem.searchController = searchField
        searchField.hidesNavigationBarDuringPresentation = false
        searchField.obscuresBackgroundDuringPresentation = false
        tableView.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func navigationSetup(_ tableView: UITableViewController, title: String){
        tableView.view.backgroundColor = K.Colors.backgroundColor
        tableView.navigationItem.title = title
        tableView.tableView.separatorStyle = .none
        tableView.navigationController?.navigationBar.barTintColor = K.Colors.navBarColor
        tableView.navigationController?.navigationBar.tintColor = .white
        tableView.navigationController?.navigationBar.barStyle = .black
        tableView.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .black), NSAttributedString.Key.foregroundColor: UIColor.white]
    }


}
