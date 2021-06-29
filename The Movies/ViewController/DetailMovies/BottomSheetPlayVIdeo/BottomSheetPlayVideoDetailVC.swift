//
//  BottomSheetPlayVideoDetailVC.swift
//  The Movies
//
//  Created by Maul on 29/06/21.
//

import UIKit
import YouTubePlayer

class BottomSheetPlayVideoDetailVC: BaseVC
{
    var actionClose: SelectionClosure?
    
    let ytPlayer: YouTubePlayerView = {
        let v = YouTubePlayerView()
        v.backgroundColor = .black
        return v
    }()
    
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
        lbl.text = "Video Trailer"
        return lbl
    }()
    
    var pathLink = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupYoutubePlayer(pathLink)
    }
    
    override func setupViews() {
        super.setupViews()
        safeview.backgroundColor = .white
        
        [containerHeader, ytPlayer].forEach { view.addSubview($0) }
        [lblTitle, containerBtn].forEach { containerHeader.addSubview($0) }
        containerBtn.addSubview(btClose)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addConstraintsWithFormat(format: "V:|-10-[v0]-10-[v1(240)]->=10-|", views: containerHeader, ytPlayer)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: ytPlayer)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]|", views: containerHeader)
        
        containerHeader.addConstraintsWithFormat(format: "H:|[v0]-10-[v1]|", views: lblTitle, containerBtn)
        containerHeader.addConstraintsWithFormat(format: "V:|->=0-[v0]->=0-|", views: lblTitle)
        lblTitle.centerYAnchor(centerY: containerHeader.centerYAnchor)
        containerHeader.addConstraintsWithFormat(format: "V:|[v0]|", views: containerBtn)

        containerBtn.addConstraintsWithFormat(format: "H:|[v0]|", views: btClose)
        containerBtn.addConstraintsWithFormat(format: "V:|[v0]|", views: btClose)
        
        btClose.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    override func buttonPressed(_ sender: UIButton) {
        actionClose?()
    }
    
    func setupYoutubePlayer(_ path: String) {
        let link = "https://www.youtube.com/watch?v=\(path)"
        if let url = URL(string: link) {
            ytPlayer.loadVideoURL(url)
        }
    }
}
