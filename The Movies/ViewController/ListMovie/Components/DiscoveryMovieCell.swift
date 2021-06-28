//
//  DiscoveryMovieCell.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class DiscoveryMovieCell: BaseTableViewCell
{
    let imgCover: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .bgSoftBlue
        img.layer.cornerRadius = 8
        img.widthAnchor.constraint(equalToConstant: 88).isActive = true
        img.heightAnchor.constraint(equalToConstant: 132).isActive = true
        return img
    }()
    
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.normal, weight: .semibold)
        lbl.numberOfLines = 0
        lbl.textColor = .darkBlue
        return lbl
    }()
    
    let lblDateReleased: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.small)
        lbl.textColor = .gray
        return lbl
    }()
    
    let lblRating: LabelWithLeftImage = {
        let lbl = LabelWithLeftImage()
        lbl.setFont(.system(.small, weight: .medium))
        lbl.setTitleColor(.gray)
        lbl.leftImageIsCenterVertical = true
        lbl.setLeftImage(.iconStar)
        lbl.leftImageHeight = 18
        return lbl
    }()
    
    let svHeader: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 8
        v.distribution = .fill
        return v
    }()
    
    let line: UIView = {
        let v = UIView()
        v.backgroundColor = .grayStroke
        return v
    }()
    
    var movie: mDiscoveryMovie? {
        didSet {
            lblTitle.text = movie?.title ?? ""
            let released = movie?.releaseDate ?? ""
            lblDateReleased.text = released == "" ? "Coming Soon" : released.convertDates()
            lblRating.setTitle("\(movie?.voteAverage.rounded(toPlaces: 1) ?? 0.0)")
            imgCover.setImage(movie?.posterPath ?? "")
        }
    }
    
    override func setupViews() {
        super.setupViews()
        selectionStyle = .none
        backgroundColor = .white
        
        [imgCover, svHeader, lblRating, line].forEach { contentView.addSubview($0) }
        [lblTitle, lblDateReleased].forEach { svHeader.addArrangedSubview($0) }
        
        [svHeader, lblRating].forEach { contentView.addConstraintsWithFormat(format: "H:|-16-[v0]-12-[v1]-16-|", views: imgCover, $0) }
        contentView.addConstraintsWithFormat(format: "V:|-[v0]-[v1(1)]|", views: imgCover, line)
        contentView.addConstraintsWithFormat(format: "V:|-[v0]->=8-[v1]-|", views: svHeader, lblRating)
        contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: line)
    }
}
