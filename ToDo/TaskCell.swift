//
//  ToDoViewCell.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 05.10.2021.
//

import UIKit

class TaskCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let todoTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkMark: UIImageView = {
        let check = UIImageView()
        check.image = UIImage(systemName: "circle")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        check.contentMode = .scaleAspectFill
        check.translatesAutoresizingMaskIntoConstraints = false
        return check
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView(contentView)
        contentView.backgroundColor = K.Colors.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellView(_ view: UIView){
        let cellStack = UIStackView(arrangedSubviews: [checkMark, cellView])
        cellStack.alignment = .center
        cellStack.axis = .horizontal
        cellStack.spacing = 10
        cellStack.translatesAutoresizingMaskIntoConstraints = false
        cellView.addSubview(todoTextLabel)
        view.addSubview(cellStack)
        NSLayoutConstraint.activate([
            checkMark.widthAnchor.constraint(equalToConstant: 30),
            checkMark.heightAnchor.constraint(equalToConstant: 30),
            cellStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cellStack.topAnchor.constraint(equalTo: view.topAnchor,
                                                  constant: 5),
            cellStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                     constant: -5),
            cellStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                      constant: 10),
            cellStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: -10),
            cellStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            cellView.heightAnchor.constraint(equalTo: cellStack.heightAnchor),
            todoTextLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            todoTextLabel.topAnchor.constraint(equalTo: cellView.topAnchor,
                                                  constant: 10),
            todoTextLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor,
                                                     constant: -10),
            todoTextLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor,
                                                      constant: 10),
            todoTextLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor,
                                                       constant: -10)            
        ])
    }
}

