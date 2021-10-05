//
//  Extensions.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 04.10.2021.
//

import UIKit
import CoreData

extension TodoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        guard let searchText = searchBar.text else { return }
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadItems()
    }
}
