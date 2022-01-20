//
//  CatalogTableViewCell.swift
//  GBShop
//
//  Created by Anna Delova on 12/31/21.
//

import UIKit

protocol CatalogCellDelegate: AnyObject {
    func didTapReview(reviews: [Review])
    func didTapAddToTheCart(product: Product)
}

class CatalogTableViewCell: UITableViewCell {

    weak var catalogDelegate: CatalogCellDelegate?
    var reviews = [Review]()
    var product: Product!


    //MARK: IBOutlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var reviewStarImage: UIImageView!
    @IBOutlet weak var reviewCountButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func configer(product: Product, reviews: Review) {

        self.product = product

        nameLabel.text =  product.name
        if let description = product.description {
            descriptionLabel.text  = description
        }
        priceLabel.text  = String(product.price)

        reviewCountButton.titleLabel?.text =  "\(reviews.starCount) reviews "
        reviewStarImage.image = getStarImage(starCount: reviews.starCount)

    }
    private func getStarImage(starCount: Int) -> UIImage {
        var image: UIImage

        switch starCount {
        case 1:
            image = UIImage(named: "1")!
        case 2:
            image = UIImage(named: "2")!
        case 3:
            image = UIImage(named: "3")!
        case 4:
            image = UIImage(named: "4")!
        case 5:
            image = UIImage(named: "5")!
        default:
            image = UIImage(named: "0")!
        }
        return image
    }

    //MARK: IBActons

    @IBAction func toShowReviews(_ sender: UIButton) {
        if let catalogDelegate = catalogDelegate {
            catalogDelegate.didTapReview(reviews: reviews)
        }

    }
    @IBAction func addToTheCart(_ sender: UIButton) {
        if let catalogDelegate = catalogDelegate {
            catalogDelegate.didTapAddToTheCart(product: product)
        }
    }

}
