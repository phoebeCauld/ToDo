//
//  ConfigView.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 02.10.2021.
//

import UIKit

struct ConfigurationForViewController {
    
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
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = K.Colors.navBarColor
        tableView.navigationController?.navigationBar.standardAppearance = navBarAppearance
        tableView.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        tableView.navigationController?.navigationBar.tintColor = .black
        tableView.navigationController?.navigationBar.prefersLargeTitles = true
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
