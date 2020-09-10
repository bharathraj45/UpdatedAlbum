//
//  PictureViewController.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import UIKit

class PictureViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: PictureViewModel!
    var albumId: Int = 0
    
    // MARK: - System events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        getPictures()
    }
    
    // MARK: - private functions
    private func setupUI() {
        setNavigationBarTitle(title: Constants.NavigationBarTitle.album)
        collectionView.register(UINib.init(nibName: Constants.Cell.pictureCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.Cell.pictureCollectionViewCell)
    }
    
    private func getPictures() {
        viewModel = PictureViewModel(userAlbums: [])
        viewModel.delegate = self
        viewModel.getPictures(albumId: albumId)
    }
}

extension PictureViewController: PictureViewDelegate {
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
        self.showAlert(title: Constants.Alert.infoText, message: Constants.Alert.errorText)
    }
}

// MARK: - collectionView datasource
extension PictureViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getRowCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cell.pictureCollectionViewCell, for: indexPath) as? PictureCollectionViewCell,
            let pictureCellModel = viewModel.getCellModel(index: indexPath.row) {
            cell.populate(pictureCellViewModel: pictureCellModel)
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - collectionView flow layout
extension PictureViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width
        return CGSize(width: width * 0.33, height: width * 0.33)
    }
}
