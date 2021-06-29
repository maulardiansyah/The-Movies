//
//  SearchMovieVC.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class SearchMovieVC: BaseVC
{
    let searchMovieCell = "searchMovieCell"
    let tableview: UITableView = {
        let v = UITableView()
        v.backgroundColor = .white
        v.separatorColor = .clear
        v.showsVerticalScrollIndicator = false
        return v
    }()
    
    let loadmore: UIView = {
        let v = UIView()
        v.isHidden = true
        v.backgroundColor = .white
        return v
    }()
    
    let svTable: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.distribution = .fill
        return v
    }()
    
    let search: UISearchBar = {
        let v = UISearchBar()
        v.placeholder = "Search movies..."
        return v
    }()
    
    let emptyView: BaseEmptyStateView = {
        let v = BaseEmptyStateView()
        v.backgroundColor = .white
        v.judul.text = "Explore your favorite movies."
        v.desc.text = "Search what you want to find some movies."
        v.desc.textColor = .gray
        v.img.image = .emptyData
        v.widthImg = 200
        return v
    }()
    
    let containerValue: UIView = {
        let v = UIView()
        return v
    }()
    
    var listMovie = [mDiscoveryMovie]()
    var page = 1
    var totalPages = 0
    var isLoadingMore = false
    
    var keySearch = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle.text = "Search"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation(isHidden: true)
    }
    
    override func setupViews() {
        super.setupViews()
        [navview, search, containerValue].forEach { safeview.addSubview($0) }
        navview.addSubview(navTitle)
        
        [tableview, loadmore].forEach { svTable.addArrangedSubview($0) }
        [emptyView, svTable].forEach { containerValue.addSubview($0) }
        svTable.isHidden = true
        
        search.delegate = self
        
        tableview.addSubview(refreshControl)
        tableview.register(DiscoveryMovieCell.self, forCellReuseIdentifier: searchMovieCell)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        [navview, search, containerValue].forEach { view.addConstraintsWithFormat(format: "H:|[v0]|", views: $0) }
        view.addConstraintsWithFormat(format: "V:|[v0(50)][v1][v2]|", views: navview, search, containerValue)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: navTitle)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: navTitle)
        
        [emptyView, svTable].forEach {
            containerValue.addConstraintsWithFormat(format: "V:|[v0]|", views: $0)
            containerValue.addConstraintsWithFormat(format: "H:|[v0]|", views: $0)
        }
    }
    
    override func refreshAction() {
        super.refreshAction()
        page = 1
        apiGetSearchMovie(loadMore: false)
    }
    
    public func scrollToTop() {
        /// Check course and table data
        if listMovie.count > 0 {
            tableview.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
        }
    }
}

//MARK: - Table Data
extension SearchMovieVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listMovie.count > 0 || isLoading {
            tableview.removeEmptyView()
        } else {
            tableview.setEmptyView(img: .emptyData, title: "Movies is empty", desc: "Can not load or found movies with keword \(keySearch)")
        }
        
        return listMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: searchMovieCell, for: indexPath) as! DiscoveryMovieCell
        cell.movie = listMovie[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectMovie(listMovie[indexPath.row])
    }
    
    func selectMovie(_ movie: mDiscoveryMovie) {
        let vc = DetailMovieVC()
        vc.movieId = movie.id ?? 0
        toNext(vc: vc)
    }
    
    /// Load more ketika sampai di konten paling akhir
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if (distanceFromBottom < height), isLoadingMore == false {
            isLoadingMore = true
            /// Jika current page kurang dari page count
            if (page < totalPages) {
                page += 1
                apiGetSearchMovie(loadMore: true)
            }
        }
    }
}

//MARK: - Search Delegate
extension SearchMovieVC: UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        search.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        keySearch = ""
        searchBar.text = ""
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.emptyView.isHidden = false /// When cancel search placeholder search will be hide
            self.svTable.isHidden = true
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        search.showsCancelButton = false
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.emptyView.isHidden = true
            self.svTable.isHidden = false
        })
        
        /// Set filter by search text
        keySearch = searchBar.text ?? ""
        page = 1
        apiGetSearchMovie(loadMore: false)
    }
}

//MARK: - API
extension SearchMovieVC
{
    func apiGetSearchMovie(loadMore: Bool) {
        loadmore.isHidden = loadMore == true ? false : true
        progressView.show(view: loadMore == true ? loadmore : view, style: loadMore == true ? .white : .whiteLarge)
        isLoading = true
        Network.request(.getMovieBySearch(keySearch, page)) { resData, error in
            self.isLoading = false
            if let e = error {
                self.view.showToast(e)
            } else {
                if let data = resData, let list = try? JSONDecoder().decode(mDiscoveryMoviesData.self, from: data) {
                    if loadMore == true {
                        let movie = list.results ?? []
                        self.listMovie.append(contentsOf: movie)
                    } else {
                        self.listMovie = list.results ?? []
                    }
                    self.totalPages = list.totalPages ?? 0
                } else {
                    self.view.showToast("Failed to decode.")
                }
            }
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
                self.progressView.hide()
                
                if loadMore == true {
                    self.loadmore.isHidden = true
                    self.isLoadingMore = false
                }
            }
        }
    }
}

