//
//  MedSliderCell.swift
//  MedTracker
//
//  Created by eyüp köse on 15.07.2024.
//

import Foundation
import UIKit

class MedSliderCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionViewImg: UIImageView!
    @IBOutlet weak var collectionViewLbl: UILabel!
    
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    // Seçim durumuna göre hücreyi yapılandıran metod
    func configure(isSelected: Bool) {
        contentView.layer.borderColor = isSelected ? UIColor(hex: "#3498db", alpha: 1.0)?.cgColor : UIColor(hex: "#ecf0f1", alpha: 1.0)?.cgColor
        contentView.layer.borderWidth = isSelected ? 2 : 1
    }
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }

}
