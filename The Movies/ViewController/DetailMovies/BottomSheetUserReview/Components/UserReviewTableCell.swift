//
//  UserReviewTableCell.swift
//  The Movies
//
//  Created by Maul on 29/06/21.
//

import UIKit

class UserReviewTableCell: BaseTableViewCell
{
    let imgProfil: UIImageView = {
        let v = UIImageView()
        v.backgroundColor = .bgSoftBlue
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 30
        return v
    }()
    
    let lblName: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.normal, weight: .semibold)
        lbl.textColor = .darkBlue
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lblRating: LabelWithLeftImage = {
        let lbl = LabelWithLeftImage()
        lbl.setFont(.system(.small, weight: .medium))
        lbl.setTitleColor(.black)
        lbl.leftImageIsCenterVertical = true
        lbl.setLeftImage(.iconStar)
        lbl.leftImageHeight = 18
        return lbl
    }()
    
    let lblDateReview: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.small)
        lbl.textColor = .gray
        return lbl
    }()
    
    let contentReview: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.normal)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let line: UIView = {
        let v = UIView()
        v.backgroundColor = .grayStroke
        return v
    }()
    
    let containerSubtitle: UIView = {
        let v = UIView()
        return v
    }()
    
    let contatinerHeader: UIView = {
        let v = UIView()
        return v
    }()
    
    let svTitle: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.distribution = .fill
        v.spacing = 6
        return v
    }()
    
    var review: mUserReview? {
        didSet {
            lblName.text = review?.authorDetails?.username ?? ""
            let date = review?.updatedAt?.datePrefixTimezone()
            lblDateReview.text = "(\(date?.convertDates() ?? ""))"
            imgProfil.setImage(review?.authorDetails?.avatarPath ?? "", placeholder: .placeholderAvatar)
            lblRating.setTitle("\(review?.authorDetails?.rating ?? 0)")
            contentReview.text = review?.content ?? ""
        }
    }
    
    override func setupViews() {
        super.setupViews()
        selectionStyle = .none
        
        [contatinerHeader, contentReview, line].forEach {contentView.addSubview($0)}
        [contatinerHeader, contentReview].forEach { contentView.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: $0) }
        contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: line)
        contentView.addConstraintsWithFormat(format: "V:|-12-[v0]-10-[v1]-12-[v2(1)]|", views: contatinerHeader, contentReview, line)
        
        [imgProfil, svTitle].forEach { contatinerHeader.addSubview($0)}
        contatinerHeader.addConstraintsWithFormat(format: "V:|[v0(60)]->=0-|", views: imgProfil)
        contatinerHeader.addConstraintsWithFormat(format: "V:|[v0]->=0-|", views: svTitle)
        contatinerHeader.addConstraintsWithFormat(format: "H:|[v0(60)]-10-[v1]|", views: imgProfil, svTitle)
        
        [lblName, containerSubtitle].forEach { svTitle.addArrangedSubview($0) }
        [lblRating, lblDateReview].forEach { containerSubtitle.addSubview($0)
            containerSubtitle.addConstraintsWithFormat(format: "V:|[v0]|", views: $0)
        }
        containerSubtitle.addConstraintsWithFormat(format: "H:|[v0]-12-[v1]->=0-|", views: lblRating, lblDateReview)
    }
}
