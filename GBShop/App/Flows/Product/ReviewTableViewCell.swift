//
//  ReviewTableViewCell.swift
//  GBShop
//
//  Created by Anna Delova on 1/14/22.
//

import UIKit

protocol ReviewCellDelegate: AnyObject {
    func didTapAddReview()
}

class ReviewTableViewCell: UITableViewCell {

    weak var reviewCellDelegate: ReviewCellDelegate?
    var review: Review?
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var starCountImage: UIImageView!
    @IBOutlet weak var reviewTextLbl: UILabel!

    public func configer(review: Review) {

        self.review = review
        customerName.text =  review.customerName
        reviewTextLbl.text = review.review
        starCountImage.image = getStarImage(starCount: review.starCount)
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
}
