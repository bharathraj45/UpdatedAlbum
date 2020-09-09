//
//  PictureCollectionViewCell.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    var pictureCellViewModel: PictureCellViewModel! {
        didSet {
            if let urlString = pictureCellViewModel.imageUrl {
                pictureImageView.setup(with: urlString, placeholderImage: nil)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
    }
    
    func populate(pictureCellViewModel: PictureCellViewModel) {
        self.pictureCellViewModel = pictureCellViewModel
    }
}
