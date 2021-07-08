//
//  SearchMoviesProtocol.swift
//  The Movies
//
//  Created by Maul on 07/07/21.
//

import UIKit

protocol SearchMoviesPresenterToViewProtocol: AnyObject {
    func showLoading(state: Bool, isLoadMore: Bool)
    func showResultMovie()
    func showError(msg: String)
}

protocol SearchMoviesInteractorToPresenterProtocol: AnyObject {
    func showLoading(state: Bool, isLoadMore: Bool)
    func moviesFetched()
    func moviesFailed(_ str: String)
}

protocol SearchMoviesPresenterToInteractorProtocol: AnyObject {
    var presenter: SearchMoviesInteractorToPresenterProtocol? { get set }
    var listMovie: [mSearchMovie]? { get }
    var page: Int { get set }
    var totalPage: Int? { get set }
    var keySearch: String? {get set}
    var isLoadMore: Bool {get set}
    var isLoading: Bool {get set}
    
    func apiGetSearchMovies()
}

protocol SearchMoviesViewToPresenterProtocol: AnyObject {
    var view: SearchMoviesPresenterToViewProtocol? { get set }
    var interactor: SearchMoviesPresenterToInteractorProtocol? { get set }
    var router: SearchMoviesPresenterToRouterProtocol? { get set }
    
    func getIsLoading() -> Bool?
    func getIsLoadingMore() -> Bool?
    func getTotalPage() -> Int?
    func getCurrentPage() -> Int?
    
    func getMoviesCount() -> Int?
    func getMovie(index: Int) -> mSearchMovie?
    
    func setIsLoadingMore(state: Bool)
    func setKeySearch(search: String)
    func setPage(page: Int)
    
    func updateView()
}

protocol SearchMoviesPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}
