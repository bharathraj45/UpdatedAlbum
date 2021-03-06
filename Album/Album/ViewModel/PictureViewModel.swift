//
//  PictureViewModel.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 09/09/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import Foundation

protocol PictureViewDelegate: AnyObject {
    func reloadData()
    func didFailWithError(error: Error)
}

class PictureViewModel {
    
    weak var delegate: PictureViewDelegate?
    
    private var userAlbums: [UserAlbum]
    
    private var servicesManager: ServicesManager
    
    init(userAlbums: [UserAlbum], servicesManager: ServicesManager) {
        self.userAlbums = userAlbums
        self.servicesManager = servicesManager
    }
    
    func getPictures(albumId: Int) {
        servicesManager.loadPicturesByAlbumId(albumId: albumId) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                if let userAlbums = result.value {
                    strongSelf.userAlbums = userAlbums
                    strongSelf.delegate?.reloadData()
                }
            case .failure(let error):
                strongSelf.delegate?.didFailWithError(error: error)
            }
        }
    }

    func getRowCount() -> Int {
        return userAlbums.count
    }
    
    func getCellModel(index: Int) -> PictureCellViewModel? {
        guard let userAlbum = userAlbums[safe: index] else { return nil }
        let pictureCellModel = PictureCellViewModel(imageUrl: userAlbum.thumbnailUrl)
        return pictureCellModel
    }
}

class PictureCellViewModel {
    var imageUrl: String?
    
    init(imageUrl: String?) {
        self.imageUrl = imageUrl
    }
}
