//
//  AlbumTitleTableViewCell.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import UIKit

class AlbumTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var albumCellViewModel: AlbumCellViewModel! {
        didSet {
            titleLabel.text = albumCellViewModel.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populate(albumCellViewModel: AlbumCellViewModel) {
        self.albumCellViewModel = albumCellViewModel
    }
}
