//
//  BaseHeaderDetailMovieView.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class BaseHeaderDetailMovieView: BaseView
{
    let imgHeader: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 220).isActive = true
        return img
    }()
    
    let btnPlay: UIButton = {
        let b = UIButton()
        b.setImage(.iconPlay, for: .normal)
        b.widthAnchor.constraint(equalToConstant: 48).isActive = true
        b.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return b
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .bgSoftBlue
        
        [imgHeader, btnPlay].forEach { addSubview($0) }
        addConstraintsWithFormat(format: "V:|[v0]|", views: imgHeader)
        addConstraintsWithFormat(format: "H:|[v0]|", views: imgHeader)
        btnPlay.centerXAnchor(centerX: centerXAnchor)
        btnPlay.centerYAnchor(centerY: centerYAnchor)
    }
    
    func stateBackDrop(_ backdropPath: String, _ video: Bool) {
        if backdropPath == "" && video == false {
            isHidden = true
        } else {
            isHidden = false
            if backdropPath == "" && video == true {
                imgHeader.backgroundColor = .black
            } else {
                imgHeader.backgroundColor = .bgSoftBlue
            }
        }
    }
}
