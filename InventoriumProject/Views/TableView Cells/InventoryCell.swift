//
//  InventoryCell.swift
//  InventoriumProject
//
//  Created by John Demirci on 10/26/20.
//  Copyright © 2020 CSUCI_350. All rights reserved.
//

import UIKit

class InventoryCell: UITableViewCell {

    static let identifier = "warehouseProductIdentifier"
    
    private let productNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "custom cell"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public func configure(text: String) {
        productNameLabel.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productNameLabel.text = nil
        productNameLabel.backgroundColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // setting the colors here
        contentView.backgroundColor = .clear
        // adding the label to the cell
        contentView.addSubview(productNameLabel)
        productNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        productNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        productNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        productNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
