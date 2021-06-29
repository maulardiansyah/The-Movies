//
//  HomeGenreVC.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit
import ImageSlideshow

class HomeGenreVC: BaseVC
{
    let imgHeader: ImageSlideshow = {
        let img = ImageSlideshow()
        img.backgroundColor = .clear
        img.slideshowInterval = 2.5
        img.contentScaleMode = .scaleAspectFill
        return img
    }()
    
    let genresCell = "genresCell"
    let collectionGenres: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    var imgHeaderData = [String]()
    var genresMovies = [mGenre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTitle.text = "Home"
        setImgHeader()
        apiGetGenres()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation(isHidden: true)
    }
    
    override func setupViews() {
        super.setupViews()
        
        statusbar.backgroundColor = .white
        [navview, imgHeader, collectionGenres].forEach { safeview.addSubview($0) }
        navview.addSubview(navTitle)
        
        collectionGenres.register(GenresCollectionCell.self, forCellWithReuseIdentifier: genresCell)
        collectionGenres.delegate = self
        collectionGenres.dataSource = self
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(sliderImagesTaped))
        imgHeader.addGestureRecognizer(recognizer)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        [navview, imgHeader, collectionGenres].forEach { view.addConstraintsWithFormat(format: "H:|[v0]|", views: $0) }
        view.addConstraintsWithFormat(format: "V:|[v0(50)][v1(180)][v2]|", views: navview, imgHeader, collectionGenres)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: navTitle)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: navTitle)
    }
    
    @objc func sliderImagesTaped() {
        imgHeader.presentFullScreenController(from: self)
    }
}

//MARK: - Collection Data
extension HomeGenreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectGenre(genresMovies[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        let colCount = 3 // Jumlah Kolom
        let margin: CGFloat = 10 * 2
        let width = (frame.width - CGFloat((colCount - 1) * 12)) - margin
        var estimatedWidth = width / CGFloat(colCount)
        estimatedWidth.round(.down)
        return .init(width: estimatedWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genresMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: genresCell, for: indexPath) as! GenresCollectionCell
        cell.menu = genresMovies[indexPath.item]
        return cell
    }
    
    func selectGenre(_ genre: mGenre) {
        let vc = DiscoveryMovieVC()
        vc.titleText = "Movie: \(genre.name ?? "")"
        vc.genreId = "\(genre.id ?? 0)"
        vc.genreName = genre.name ?? ""
        toNext(vc: vc)
    }
}

//MARK: Set Data & API
extension HomeGenreVC
{
    func setImgHeader() {
        imgHeaderData = [
            "https://www.themoviedb.org/t/p/w1066_and_h600_bestv2/wiqOdWT643wYXSGvSGLjdQSkwpM.jpg",
            "https://www.themoviedb.org/t/p/w1066_and_h600_bestv2/pPJeTeW4uDdPDYIpnA7Ut1qqEBR.jpg",
            "https://www.themoviedb.org/t/p/w1066_and_h600_bestv2/am782sUaTOGcEPEdUUjybwUZP1f.jpg"
        ]
        
        var sources = [InputSource]()
        for i in 0..<imgHeaderData.count {
            if let url = URL(string: imgHeaderData[i]) {
                sources.append(KingfisherSource(url: url))
            }
        }
        imgHeader.setImageInputs(sources)
    }
    
    func apiGetGenres() {
        progressView.show(view: view)
        isLoading = true
        Network.request(.getListGenres) { resData, error in
            self.isLoading = false
            if let e = error {
                self.view.showToast(e)
            } else {
                if let data = resData, let genre = try? JSONDecoder().decode(mGenresData.self, from: data) {
                    self.genresMovies = genre.genres ?? []
                } else {
                    self.view.showToast("Failed to decode.")
                }
            }
            
            DispatchQueue.main.async {
                self.collectionGenres.reloadData()
                self.progressView.hide()
            }
        }
    }
}
