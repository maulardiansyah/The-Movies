//
//  DetailMovieVC.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class DetailMovieVC: BaseVC
{
    let sectionHeader = "sectionHeaderCell"
    let sectionInfo = "sectionInfo"
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
    
    var movieId = 0
    var movieDetails: mDiscoveryMovie?
    var movieVideoTrailer: mVideoMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle("Detail Movie")
        apiGetMovieDetails()
    }
    
    override func setupViews() {
        super.setupViews()
        safeview.backgroundColor = .white
        
        [line, tableview].forEach { safeview.addSubview($0) }
        
        tableview.register(DetailSectionHeaderCell.self, forCellReuseIdentifier: sectionHeader)
        tableview.register(DetailSectionInfoCell.self, forCellReuseIdentifier: sectionInfo)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        [line, tableview].forEach { view.addConstraintsWithFormat(format: "H:|[v0]|", views: $0) }
        view.addConstraintsWithFormat(format: "V:|[v0(1)][v1]|", views: line, tableview)
    }
}

//MARK: - Table Data
extension DetailMovieVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetails != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableview.dequeueReusableCell(withIdentifier: sectionInfo, for: indexPath) as! DetailSectionInfoCell
            cell.movieInfo = movieDetails
            return cell
        }
        
        let cell = tableview.dequeueReusableCell(withIdentifier: sectionHeader, for: indexPath) as! DetailSectionHeaderCell
        cell.movieTrailer = movieVideoTrailer
        cell.movieHeaderSection = movieDetails
        return cell
    }
}

//MARK: - API
extension DetailMovieVC
{
    func apiGetMovieDetails() {
        progressView.show(view: view)
        isLoading = true
        Network.request(.getMovieDetail(movieId)) { resData, error in
            self.progressView.hide()
            self.isLoading = false
            if let e = error {
                self.view.showToast(e)
            } else {
                if let data = resData, let list = try? JSONDecoder().decode(mDiscoveryMovie.self, from: data) {
                    self.movieDetails = list
                    self.apiGetVideoTrailer()
                } else {
                    self.view.showToast("Failed to decode.")
                }
            }
        }
    }
    
    func apiGetVideoTrailer() {
        progressView.show(view: view)
        isLoading = true
        Network.request(.getVideoMovie(movieId)) { resData, error in
            self.isLoading = false
            if let e = error {
                self.view.showToast(e)
            } else {
                if let data = resData, let list = try? JSONDecoder().decode(mListVideos.self, from: data) {
                    let videoFilter = list.results?.filter { $0.site == "YouTube" && $0.type == "Trailer" }
                    self.movieVideoTrailer = videoFilter?.first
                } else {
                    self.view.showToast("Failed to decode.")
                }
            }
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
                self.progressView.hide()
            }
        }
    }
}
