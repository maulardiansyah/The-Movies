//
//  SearchMoviesInteractor.swift
//  The Movies
//
//  Created by Maul on 07/07/21.
//

import UIKit

class SearchMoviesInteractor: SearchMoviesPresenterToInteractorProtocol
{
    var presenter: SearchMoviesInteractorToPresenterProtocol?
    var listMovie: [mSearchMovie]?
    
    var page: Int = 1
    var totalPage: Int? = 0
    var isLoadMore: Bool = false
    var isLoading: Bool = true
    var keySearch: String? = ""
    
    func apiGetSearchMovies() {
        isLoading = true
        presenter?.showLoading(state: isLoading, isLoadMore: isLoadMore)
        Network.request(.getMovieBySearch(keySearch ?? "", page)) { resData, error in
            self.isLoading = false
            if let e = error {
                self.presenter?.moviesFailed(e)
            } else {
                if let data = resData, let list = try? JSONDecoder().decode(mSearchMoviesData.self, from: data) {
                    if self.isLoadMore == true {
                        self.isLoadMore = false
                        self.listMovie?.append(contentsOf: list.results ?? [] )
                    } else {
                        self.listMovie = list.results ?? []
                    }
                    self.totalPage = list.totalPages ?? 0
                } else {
                    self.presenter?.moviesFailed("Failed to decode.")
                }
            }
            
            DispatchQueue.main.async {
                self.presenter?.moviesFetched()
            }
        }
    }
}
