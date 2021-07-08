//
//  SearchMovieView.swift
//  The Movies
//
//  Created by Maul on 07/07/21.
//

import UIKit

class SearchMovieView: UIViewController
{
    @IBOutlet weak var naviTitle: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var svTable: UIStackView!
    @IBOutlet weak var tableListMovie: UITableView!
    @IBOutlet weak var loadMoreView: UIView!
    
    @IBOutlet weak var emptyStatePlaceholderSearch: UIView!
    @IBOutlet weak var titleEmptyPlaceholder: UILabel!
    @IBOutlet weak var descEmptyPlaceholder: UILabel!
    
    var presenter: SearchMoviesViewToPresenterProtocol?
    let progressView = ProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        naviTitle.text = "Search"
        naviTitle.textColor = .darkBlue
        setupTable()
        setupEmptyStatePlaceholder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - CofigureView
    func setupTable() {
        svTable.isHidden = true
        
        tableListMovie.register(ListMovieCell.movieCellNib(), forCellReuseIdentifier: ListMovieCell.identifier)
        tableListMovie.delegate = self
        tableListMovie.dataSource = self
    }
    
    func setupEmptyStatePlaceholder() {
        titleEmptyPlaceholder.text = "Explore your favorite movies."
        descEmptyPlaceholder.text = "Search what you want to find some movies."
        descEmptyPlaceholder.textColor = .gray
    }
    
    public func scrollToTop() {
        /// Check course and table data
        if presenter?.getMoviesCount() ?? 0 > 0 {
            tableListMovie.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
        }
    }
}

//MARK: - Table Data
extension SearchMovieView: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter?.getMoviesCount() ?? 0 > 0 || presenter?.getIsLoading() ?? true == true {
            tableView.removeEmptyView()
        } else {
            tableView.setEmptyView(img: .emptyData, title: "Movies is empty", desc: "Can not load or found movies with keword \(presenter?.interactor?.keySearch ?? "")")
        }
        return presenter?.getMoviesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieCell.identifier, for: indexPath) as! ListMovieCell
        let movie = presenter?.getMovie(index: indexPath.row)
        cell.setValueCell(movie?.posterPath ?? "",
                          movie?.title ?? "",
                          movie?.releaseDate?.convertDates() ?? "",
                          movie?.voteAverage.rounded(toPlaces: 1) ?? 0.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectMovie(presenter?.getMovie(index: indexPath.row))
    }
    
    func selectMovie(_ movie: mSearchMovie?) {
        let vc = DetailMovieVC()
        vc.movieId = movie?.id ?? 0
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// Load more ketika sampai di konten paling akhir
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if (distanceFromBottom < height), presenter?.getIsLoadingMore() == false {
            presenter?.setIsLoadingMore(state: true)
            
            /// Jika current page kurang dari page count
            let currentPage = presenter?.getCurrentPage() ?? 0
            if (currentPage < presenter?.getTotalPage() ?? 0) {
                presenter?.setPage(page: currentPage+1)
                presenter?.updateView()
            }
        }
    }
}

extension SearchMovieView: UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.interactor?.keySearch = ""
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.emptyStatePlaceholderSearch?.isHidden = false
            self.svTable.isHidden = true
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.emptyStatePlaceholderSearch?.isHidden = true
            self.svTable.isHidden = false
        })
        
        /// Set filter by search text
        presenter?.setKeySearch(search: searchBar.text ?? "")
        presenter?.setPage(page: 1)
        presenter?.updateView()
    }
}

//MARK: - Preseter To View Protocol
extension SearchMovieView: SearchMoviesPresenterToViewProtocol
{
    func showResultMovie() {
        loadMoreView.isHidden = true
        tableListMovie.reloadData()
        if presenter?.getIsLoading() ?? false == false {
            self.progressView.hide()
        }
    }
    
    func showError(msg: String) {
        view.showToast(msg)
    }
    
    func showLoading(state: Bool, isLoadMore: Bool) {
        if state {
            loadMoreView.isHidden = isLoadMore ? false :  true
            progressView.show(view: isLoadMore ? loadMoreView : view)
        }
    }
}
