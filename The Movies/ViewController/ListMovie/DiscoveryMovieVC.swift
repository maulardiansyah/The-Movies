//
//  DiscoveryMovieVC.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class DiscoveryMovieVC: BaseVC
{
    let discoveryMovieCell = "discoveryMovieCell"
    let tableview: UITableView = {
        let v = UITableView()
        v.backgroundColor = .clear
        v.separatorColor = .clear
        v.showsVerticalScrollIndicator = false
        return v
    }()
    
    let line: UIView = {
        let v = UIView()
        v.backgroundColor = .grayStroke
        return v
    }()
    
    let loadmore: UIView = {
        let v = UIView()
        v.isHidden = true
        v.backgroundColor = .white
        return v
    }()
    
    let svValue: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.distribution = .fill
        return v
    }()
    
    var genreId = ""
    var genreName = ""
    
    var discoveryMovie = [mDiscoveryMovie]()
    var page = 1
    var totalPages = 0
    var isLoadingMore: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle(titleText)
        apiGetDiscoveryMovie(loadMore: false)
    }
    
    override func setupViews() {
        super.setupViews()
        
        [line, svValue].forEach { safeview.addSubview($0) }
        [tableview, loadmore].forEach { svValue.addArrangedSubview($0) }
        
        tableview.addSubview(refreshControl)
        tableview.register(DiscoveryMovieCell.self, forCellReuseIdentifier: discoveryMovieCell)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addConstraintsWithFormat(format: "V:|[v0(1)][v1]|", views: line, svValue)
        [line, svValue].forEach { view.addConstraintsWithFormat(format: "H:|[v0]|", views: $0) }
    }
    
    override func refreshAction() {
        super.refreshAction()
        page = 1
        apiGetDiscoveryMovie(loadMore: false)
    }
}

//MARK: - Table Data
extension DiscoveryMovieVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if discoveryMovie.count > 0 || isLoading {
            tableview.removeEmptyView()
        } else {
            tableview.setEmptyView(img: .emptyData, title: "Movies is empty", desc: "Can not load or found movies with genre \(genreName)")
        }
        
        return discoveryMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: discoveryMovieCell, for: indexPath) as! DiscoveryMovieCell
        cell.movie = discoveryMovie[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectMovie(discoveryMovie[indexPath.row])
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
                apiGetDiscoveryMovie(loadMore: true)
            }
        }
    }
}

//MARK: - API
extension DiscoveryMovieVC
{
    func apiGetDiscoveryMovie(loadMore: Bool) {
        loadmore.isHidden = loadMore == true ? false : true
        progressView.show(view: loadMore == true ? loadmore : view, style: loadMore == true ? .white : .whiteLarge)
        isLoading = true
        Network.request(.getDiscoverMovies(genreId, page)) { resData, error in
            self.isLoading = false
            if let e = error {
                self.view.showToast(e)
            } else {
                if let data = resData, let list = try? JSONDecoder().decode(mDiscoveryMoviesData.self, from: data) {
                    if loadMore == true {
                        let movie = list.results ?? []
                        self.discoveryMovie.append(contentsOf: movie)
                    } else {
                        self.discoveryMovie = list.results ?? []
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
