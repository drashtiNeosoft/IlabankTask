//
//  AlbumViewModel.swift
//  IlabankDemo
//
//  Created by Drashti Javiya on 02/03/22.
//

import Foundation

class AlbumViewModel {
    var albumList: [AlbumModel]?
    var searchAlbumList: [AlbumModel]?
    var isSearch = false
    var selectedBannerIndex = 0
    var serachText = ""
    
    /// Get album list from json Data
    func getAlbumsDetail(completion: ((_ isSuccess: Bool)-> Void)) {
        if let path = Bundle.main.path(forResource: "Album", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                let albumList = try jsonDecoder.decode([AlbumModel].self, from: data)
                self.albumList = albumList
                completion(true)
              } catch {
                   // handle error
                  completion(false)
              }
        } else {
            completion(false)
        }
    }
    
    /// Get album list count based on search
    func getListCount() -> Int {
        if !isSearch {
            return albumList?.count ?? 0
        } else {
            return searchAlbumList?.count ?? 0
        }
    }
    
    /// Get album list count based on search
    func getcarouselListCount() -> Int {
        return albumList?.count ?? 0
    }
    
    /// Get album based on search / non-search
    func getSelectedBanner(index: Int) -> AlbumModel? {
        return albumList?[index]
    }
    
    /// Get album based on search / non-search
    func getSelectedAlbum(index: Int) -> AlbumModel? {
        if !isSearch {
            return albumList?[index]
        } else {
            return searchAlbumList?[index]
        }
    }
    
    func setSelectedBannerIndex(index: Int) {
        selectedBannerIndex = index
    }
    
    /// Search list
    func searchList(searchText: String) {
        if searchText == "" {
            isSearch = false
        } else {
            isSearch = true
            let predicate = NSPredicate(format: "SELF contains[c] %@", searchText)
            searchAlbumList = albumList?.filter { predicate.evaluate(with: $0.title ?? "") }
        }
    }
}
