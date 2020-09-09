//
//  AlbumTests.swift
//  AlbumTests
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import XCTest
@testable import Album

class AlbumTests: XCTestCase {
    
    var albumCellViewModel: AlbumCellViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        albumCellViewModel = AlbumCellViewModel(title: "test")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        albumCellViewModel = nil
    }
    
    // unit test with red green and refactor
    func testViewModelDataFail() {
        let album = Album(userId: 1, id: 1, title: "first")
        XCTAssertEqual(album.title, albumCellViewModel.title)
    }
    
    func testViewModelDataPass() {
        let album = Album(userId: 1, id: 1, title: "test")
        XCTAssertEqual(album.title, albumCellViewModel.title)
    }
}
