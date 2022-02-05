//
//  CategoryCell.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 05.10.2021.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    let todoTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tasksCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellView(_ view: UIView){
        let textStack = UIStackView(arrangedSubviews: [todoTextLabel,tasksCountLabel])
        textStack.alignment = .leading
        textStack.axis = .vertical
        textStack.distribution = .fill
        textStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textStack)
        NSLayoutConstraint.activate([
            textStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textStack.topAnchor.constraint(equalTo: view.topAnchor,
                                                  constant: 10),
            textStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                     constant: -10),
            textStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                      constant: 15),
            textStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: -15),
            textStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
}
