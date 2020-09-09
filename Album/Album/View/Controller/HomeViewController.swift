//
//  HomeViewController.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    private var viewModel = AlbumViewModel()
    
    // MARK: - System events
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAlbums()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //show the screen based on segue identifier
        if segue.identifier == Constants.SegueIdentifiers.homeToPictureView {
            if let pictureViewController = segue.destination as? PictureViewController,
                let indexPath = self.tableview.indexPathForSelectedRow,
                let albumId = viewModel.selectedAlbumId(index: indexPath.row) {
                pictureViewController.albumId = albumId
                clearSearch()
            }
        }
    }
    
    // MARK: - private functions
    private func setupUI() {
        setNavigationBarTitle(title: Constants.NavigationBarTitle.albums)
        tableview.register(UINib.init(nibName: Constants.Cell.albumTitleTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Cell.albumTitleTableViewCell)
    }
    
    private func getAlbums() {
        viewModel.delegate = self
        viewModel.getAlbums()
    }
}

extension HomeViewController: AlbumDelegate {
    func reloadData() {
        self.tableview.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
        self.showAlert(title: Constants.Alert.infoText, message: Constants.Alert.errorText)
    }
}

// MARK: - tableview datasource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.albumTitleTableViewCell, for: indexPath) as? AlbumTitleTableViewCell {
            if let albumCellModel = viewModel.getCellModel(index: indexPath.row) {
                cell.populate(albumCellViewModel: albumCellModel)
                return cell
            }
        }
        return UITableViewCell()
    }
}

// MARK: - tableview delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.SegueIdentifiers.homeToPictureView, sender: self)
    }
}

// MARK: - searchbar delegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch()
        getAlbums()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getSearchUpdate(searchText: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getSearchUpdate(searchText: searchText)
    }
    
    private func clearSearch() {
        searchBar.resignFirstResponder()
        viewModel.updateIsSearch(isSearch: false)
        searchBar.text = ""
    }
}
