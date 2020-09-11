//
//  AlbumViewModel.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 04/09/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import Foundation

protocol AlbumDelegate: AnyObject {
    func reloadData()
    func didFailWithError(error: Error)
}

class AlbumViewModel {
    
    weak var delegate: AlbumDelegate?
    
    private var albums: [Album]
    private var filteredAlbums: [Album]
    private var isSearch: Bool
    
    private var servicesManager: ServicesManager
    
    init(albums: [Album], filteredAlbums: [Album], isSearch: Bool = false, servicesManager: ServicesManager) {
        self.albums = albums
        self.filteredAlbums = filteredAlbums
        self.isSearch = isSearch
        self.servicesManager = servicesManager
    }
    
    func getAlbums() {
        servicesManager.loadAlbums { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                if let albums = result.value {
                    strongSelf.albums = albums
                    strongSelf.delegate?.reloadData()
                }
            case .failure(let error):
                strongSelf.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    func getRowCount() -> Int {
        return isSearch ? filteredAlbums.count : albums.count
    }
    
    func selectedAlbumId(index: Int) -> Int? {
        return isSearch ? filteredAlbums[safe: index]?.id : albums[safe: index]?.id
    }
    
    func getCellModel(index: Int) -> AlbumCellViewModel? {
        var albumCellViewModel: AlbumCellViewModel?
        if isSearch {
            guard let filteredAlbum = filteredAlbums[safe: index] else { return nil }
            albumCellViewModel = AlbumCellViewModel(title: filteredAlbum.title)
        }
        else {
            guard let album = albums[safe: index] else { return nil }
            albumCellViewModel = AlbumCellViewModel(title: album.title)
        }
        return albumCellViewModel
    }
     
    func getSearchUpdate(searchText: String?) {
        if let searchText = searchText,
            !searchText.isEmpty {
            isSearch = true
            let updatedAlbums = albums.filter({ ($0.title.lowercased().contains(searchText.lowercased())) })
            filteredAlbums = updatedAlbums
        } else {
            isSearch = false
        }
        delegate?.reloadData()
    }
    
    func updateIsSearch(isSearch: Bool) {
        self.isSearch = isSearch
    }
}

class AlbumCellViewModel {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
