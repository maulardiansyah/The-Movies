//
//  BaseFooterDetailMovieView.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class BaseFooterDetailMovieView: BaseView
{
    let lblRating: LabelWithLeftImage = {
        let lbl = LabelWithLeftImage()
        lbl.setFont(.system(.medium, weight: .semibold))
        lbl.setTitleColor(.darkBlue)
        lbl.labelCenterVertical = true
        lbl.setLeftImage(.iconStar)
        lbl.leftImageHeight = 24
        return lbl
    }()
    
    let containerRating: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-1) / 2).isActive = true
        return v
    }()
    
    let valVoteCount: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.medium, weight: .semibold)
        lbl.textColor = .darkBlue
        lbl.textAlignment = .center
        return lbl
    }()
    
    let lblVoteCount: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.xsmall)
        lbl.textColor = .gray
        lbl.text = "Vote Count"
        lbl.textAlignment = .center
        return lbl
    }()
    
    let svVoteCout: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 2
        v.distribution = .fill
        return v
    }()
    
    let btnSeeAllReview: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = .system(.small, weight: .semibold)
        b.setTitleColor(.darkBlue, for: .normal)
        b.setTitle("See All Reviews", for: .normal)
        return b
    }()
    
    let containerVoteCount: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width-1) / 2).isActive = true
        return v
    }()
    
    let containerRecap: UIView = {
        let v = UIView()
        return v
    }()
    
    let separator: UIView = {
        let v = UIView()
        v.backgroundColor = .grayStroke
        return v
    }()
    
    let containerBtn: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    override func setupViews() {
        super.setupViews()
    
        [containerRecap, containerBtn].forEach { addSubview($0)
            addConstraintsWithFormat(format: "H:|[v0]|", views: $0)
        }
        
        [containerRating, separator, containerVoteCount, btnSeeAllReview].forEach { containerRecap.addSubview($0) }
        containerRating.addSubview(lblRating)
        
        containerVoteCount.addSubview(svVoteCout)
        [valVoteCount, lblVoteCount].forEach { svVoteCout.addArrangedSubview($0) }
        
        containerRecap.addConstraintsWithFormat(format: "H:|[v0][v1(2)][v2]|", views: containerRating, separator, containerVoteCount)
        [containerRating, containerVoteCount].forEach { containerRecap.addConstraintsWithFormat(format: "V:|[v0(54)]|", views: $0) }
        containerRecap.addConstraintsWithFormat(format: "V:|-4-[v0]-4-|", views: separator)
        
        lblRating.centerYAnchor(centerY: containerRating.centerYAnchor)
        lblRating.centerXAnchor(centerX: containerRating.centerXAnchor)
        
        svVoteCout.centerYAnchor(centerY: containerVoteCount.centerYAnchor)
        svVoteCout.centerXAnchor(centerX: containerVoteCount.centerXAnchor)
        
        addConstraintsWithFormat(format: "V:|[v0(54)][v1(40)]|", views: containerRecap, containerBtn)
        
        containerBtn.addSubview(btnSeeAllReview)
        btnSeeAllReview.centerXAnchor(centerX: containerBtn.centerXAnchor)
        btnSeeAllReview.centerYAnchor(centerY: containerBtn.centerYAnchor)
    }
}
