//
//  MainViewModel.swift
//  Dispo Take Home
//
//  Created by Ikechukwu Onuorah on 17/01/2022.
//

import Foundation

class MainViewModel {
    private var gifRepository: RemoteRepository?
    
    init() {
        self.gifRepository = RemoteRepository()
    }
    
    func fetchTrendingGifs(success: @escaping (APIListResponse) -> (), failure: @escaping (String) -> ()) {
        gifRepository?.getTrendingGifs(
            success: {(trendingGifs: APIListResponse) in
                success(trendingGifs)
            },
            failure: { (error) in
                failure(error)
            }
        )
    }
    
    func fetchSearchGifs(word: String, success: @escaping (APIListResponse) -> (), failure: @escaping (String) -> ()) {
        gifRepository?.getSearchGifs(
            searchString: word,
            success: {searchResults in
                success(searchResults)
            },
            failure: {error in
                failure(error)
            }
        )
    }
}
