//
//  AlbumServiceManager.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import Foundation
import Alamofire

extension ServicesManager {
    
    @discardableResult func loadAlbums(completion: @escaping (Result<[Album]>) -> Void) -> Request? {
        let urlString = "https://jsonplaceholder.typicode.com/albums"
        return sendRequest(urlString: urlString, parameters: nil, method: HTTPMethod.get, completion: completion)
    }
    
    @discardableResult func loadPicturesByAlbumId(albumId: Int, completion: @escaping (Result<[UserAlbum]>) -> Void) -> Request? {
        let urlString = "https://jsonplaceholder.typicode.com/albums/" + "\(albumId)" + "/photos"
        return sendRequest(urlString: urlString, parameters: nil, method: HTTPMethod.get, completion: completion)
    }
    
    //TODO: - explore on using this api
    @discardableResult func searchAlbumsByUserId(userId: Int, completion: @escaping (Result<[Album]>) -> Void) -> Request? {
        let urlString = "https://jsonplaceholder.typicode.com/posts?userId=" + "\(userId)"
        return sendRequest(urlString: urlString, parameters: nil, method: HTTPMethod.get, completion: completion)
    }
}
