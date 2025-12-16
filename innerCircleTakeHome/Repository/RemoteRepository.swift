//
//  RemoteRepository.swift
//  Dispo Take Home
//
//  Created by Ikechukwu Onuorah on 17/01/2022.
//

import Foundation

struct RemoteRepository {
    private var client = GifAPIClient()
    
    func getTrendingGifs(success: @escaping (APIListResponse) -> (), failure: @escaping (String) -> ()) {
        client.request(
            endpointType: .trending,
            params: ["rating": "pg"],
            success:  {(response: APIListResponse) in
                success(response)
            },
            failure: { (error) in
                failure(error)
            }
        )
    }
    
    func getSearchGifs(searchString: String, success: @escaping (APIListResponse) -> (), failure: @escaping (String) -> ()) {
        client.request(
            endpointType: .search,
            params: ["q": searchString],
            success: {(searchResults: APIListResponse) in
                success(searchResults)
            },
            failure: {error in
                failure(error)
            }
        )
    }
    
    func getGif(gifId: String, success: @escaping (APIDetailResponse) -> (), failure: @escaping (String) -> ()) {
        client.request(
            endpointType: .gifId(gifId),
            success: {(gifInfo: APIDetailResponse) in
                success(gifInfo)
            },
            failure: {error in
                failure(error)
            }
        )
    }
}
