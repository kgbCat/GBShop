//
//  CatalogTableViewCell.swift
//  GBShop
//
//  Created by Anna Delova on 12/31/21.
//

import UIKit

protocol CatalogCellDelegate: AnyObject {
    func didTapAddToTheCart(product: Product)
}

class CatalogTableViewCell: UITableViewCell {

    weak var catalogDelegate: CatalogCellDelegate?
    var product: Product!

    //MARK: IBOutlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func configer(product: Product) {

        self.product = product

        nameLabel.text =  product.name
        if let description = product.description {
            descriptionLabel.text  = description
        }
        priceLabel.text  = "\(product.price) rub"

    }

    //MARK: IBActons

    @IBAction func addToTheCart(_ sender: UIButton) {
        if let catalogDelegate = catalogDelegate {
            catalogDelegate.didTapAddToTheCart(product: product)
        }
    }

}
