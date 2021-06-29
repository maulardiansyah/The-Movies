//
//  BottomSheetReviewDetailVC.swift
//  The Movies
//
//  Created by Maul on 29/06/21.
//

import UIKit

class BottomSheetReviewDetailVC: BaseVC
{
    var actionClose: SelectionClosure?
    
    let btClose: UIButton = {
        let v = UIButton()
        v.tintColor = .darkBlue
        v.imageView?.contentMode = .scaleAspectFit
        v.setImage(.btClose, for: .normal)
        v.widthAnchor.constraint(equalToConstant: 48).isActive = true
        v.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return v
    }()
    
    let containerHeader: UIView = {
        let v = UIView()
        return v
    }()
    
    let containerBtn: UIView = {
        let v = UIView()
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.normal, weight: .semibold)
        lbl.numberOfLines = 0
        lbl.text = "Reviews"
        return lbl
    }()
    
    let userReviewCell = "userReviewCell"
    let tableView: UITableView = {
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
    
    var movieId = 0
    
    var listReview = [mUserReview]()
    var page = 1
    var totalPages = 0
    var isLoadingMore = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiGetUserReview(loadMore: false)
    }
    
    override func setupViews() {
        super.setupViews()
        safeview.backgroundColor = .white
        
        [containerHeader, svTable].forEach { view.addSubview($0) }
        [lblTitle, containerBtn].forEach { containerHeader.addSubview($0) }
        containerBtn.addSubview(btClose)
        [tableView, loadmore].forEach { svTable.addArrangedSubview($0) }
        
        tableView.addSubview(refreshControl)
        tableView.register(UserReviewTableCell.self, forCellReuseIdentifier: userReviewCell)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addConstraintsWithFormat(format: "V:|-10-[v0]-[v1]|", views: containerHeader, svTable)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: svTable)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]|", views: containerHeader)
        
        containerHeader.addConstraintsWithFormat(format: "H:|[v0]-10-[v1]|", views: lblTitle, containerBtn)
        containerHeader.addConstraintsWithFormat(format: "V:|->=0-[v0]->=0-|", views: lblTitle)
        lblTitle.centerYAnchor(centerY: containerHeader.centerYAnchor)
        containerHeader.addConstraintsWithFormat(format: "V:|[v0]|", views: containerBtn)

        containerBtn.addConstraintsWithFormat(format: "H:|[v0]|", views: btClose)
        containerBtn.addConstraintsWithFormat(format: "V:|[v0]|", views: btClose)
        
        btClose.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    override func refreshAction() {
        super.refreshAction()
        page = 1
        apiGetUserReview(loadMore: false)
    }
    
    override func buttonPressed(_ sender: UIButton) {
        actionClose?()
    }
}

//MARK: - Table Data
extension BottomSheetReviewDetailVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listReview.count > 0 || isLoading {
            tableView.removeEmptyView()
        } else {
            tableView.setEmptyView(img: .emptyData, title: "There are no reviews for this movie yet", desc: "please do a review on this film.")
        }
        
        return listReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userReviewCell, for: indexPath) as! UserReviewTableCell
        cell.review = listReview[indexPath.row]
        return cell
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
                apiGetUserReview(loadMore: true)
            }
        }
    }
}

//MARK: - API
extension BottomSheetReviewDetailVC
{
    func apiGetUserReview(loadMore: Bool) {
        loadmore.isHidden = loadMore == true ? false : true
        progressView.show(view: loadMore == true ? loadmore : view, style: loadMore == true ? .white : .whiteLarge)
        isLoading = true
        Network.request(.getMovieReview(movieId, page)) { resData, error in
            self.isLoading = false
            if let e = error {
                self.view.showToast(e)
            } else {
                if let data = resData, let list = try? JSONDecoder().decode(mListMovieReviews.self, from: data) {
                    let review = list.results ?? []
                    if loadMore == true {
                        self.listReview.append(contentsOf: review)
                    } else {
                        self.listReview = review
                    }
                    self.totalPages = list.totalPages ?? 0
                } else {
                    self.view.showToast("Failed to decode.")
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.progressView.hide()
                
                if loadMore == true {
                    self.loadmore.isHidden = true
                    self.isLoadingMore = false
                }
            }
        }
    }
}
