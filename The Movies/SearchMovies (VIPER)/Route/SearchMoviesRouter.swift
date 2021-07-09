//
//  SearchMoviesRouter.swift
//  The Movies
//
//  Created by Maul on 07/07/21.
//

import UIKit

class SearchMoviesRouter: SearchMoviesPresenterToRouterProtocol
{
    static func createModule() -> UIViewController {
        let view = SearchMovieView()
        let presenter: SearchMoviesViewToPresenterProtocol & SearchMoviesInteractorToPresenterProtocol = SearchMoviesPresenter()
        let interactor: SearchMoviesPresenterToInteractorProtocol = SearchMoviesInteractor()
        let router: SearchMoviesPresenterToRouterProtocol = SearchMoviesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func toDetailMovie(movie: mSearchMovie?) -> UIViewController {
        let view = DetailMovieVC()
        view.movieId = movie?.id ?? 0
        return view
    }
}
