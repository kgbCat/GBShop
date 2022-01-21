//
//  BasketTableViewCell.swift
//  GBShop
//
//  Created by Anna Delova on 1/15/22.
//

import UIKit


class BasketTableViewCell: UITableViewCell {

    var product: Product!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    public func configer(product: Product) {

        self.product = product

        nameLabel.text =  product.name
        if let description = product.description {
            descriptionLabel.text  = description
        }
        priceLabel.text  = "\(product.price) rub"
    }
    
}
