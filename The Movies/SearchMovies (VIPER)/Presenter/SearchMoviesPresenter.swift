//
//  SearchMoviesPresenter.swift
//  The Movies
//
//  Created by Maul on 08/07/21.
//

import UIKit

//MARK: - View To Intercator
class SearchMoviesPresenter: SearchMoviesViewToPresenterProtocol
{
    var view: SearchMoviesPresenterToViewProtocol?
    var interactor: SearchMoviesPresenterToInteractorProtocol?
    var router: SearchMoviesPresenterToRouterProtocol?
    
    func getIsLoadingMore() -> Bool? {
        interactor?.isLoadMore
    }
    
    func getIsLoading() -> Bool? {
        interactor?.isLoading
    }
    
    func getCurrentPage() -> Int? {
        interactor?.page
    }
    
    func getTotalPage() -> Int? {
        interactor?.totalPage
    }
    
    func getMovie(index: Int) -> mSearchMovie? {
        return interactor?.listMovie?[index]
    }
    
    func getMoviesCount() -> Int? {
        interactor?.listMovie?.count
    }
    
    func setPage(page: Int) {
        interactor?.page = page
    }
    
    func setKeySearch(search: String) {
        interactor?.keySearch = search
    }
    
    func setIsLoadingMore(state: Bool) {
        interactor?.isLoadMore = state
    }
    
    func updateView() {
        interactor?.apiGetSearchMovies()
    }
    
    func selectList(movie: mSearchMovie?) {
        let detailView = router?.toDetailMovie(movie: movie)
        view?.moveToDetail(view: detailView!)
    }
}

//MARK: - Interacto To Presenter
extension SearchMoviesPresenter: SearchMoviesInteractorToPresenterProtocol
{
    func moviesFetched() {
        view?.showResultMovie()
    }
    
    func moviesFailed(_ str: String) {
        view?.showError(msg: str)
    }
    
    func showLoading(state: Bool, isLoadMore: Bool) {
        view?.showLoading(state: state, isLoadMore: isLoadMore)
    }
    
}
