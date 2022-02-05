//
//  ToDoViewCell.swift
//  ToDo
//
//  Created by F1xTeoNtTsS on 05.10.2021.
//

import UIKit

class TaskCell: UITableViewCell {

    let todoTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let checkMark: UIImageView = {
        let check = UIImageView()
        check.tintColor = .black
        check.contentMode = .scaleAspectFill
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
        let cellStack = UIStackView(arrangedSubviews: [checkMark, todoTextLabel])
        cellStack.alignment = .center
        cellStack.axis = .horizontal
        cellStack.spacing = 10
        cellStack.translatesAutoresizingMaskIntoConstraints = false
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
            cellStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
}

