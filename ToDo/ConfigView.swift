//
//  ConfigView.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 02.10.2021.
//

import UIKit

struct ConfigTableViewController {
    
    func navigationSetup(_ tableView: UITableViewController){
        tableView.navigationItem.title = "ToDo"
        tableView.navigationController?.navigationBar.barTintColor = .systemBlue
        tableView.navigationController?.navigationBar.tintColor = .white
        tableView.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .black), NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
    }


}
