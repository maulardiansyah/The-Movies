//
//  DetailSectionHeaderCell.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class DetailSectionHeaderCell: BaseTableViewCell
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
    
    let lblRuntime: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.small)
        lbl.textColor = .gray
        return lbl
    }()
    
    let svTitle: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 6
        v.distribution = .fill
        return v
    }()
    
    let svHeader: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.distribution = .fill
        return v
    }()
    
    let imgAdult: UIImageView = {
        let img = UIImageView()
        img.image = .iconAdult
        img.contentMode = .scaleAspectFit
        img.widthAnchor.constraint(equalToConstant: 24).isActive = true
        img.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return img
    }()
    
    let containerValue: UIView = {
        let v = UIView()
        return v
    }()
    
    let containerAdult: UIView = {
        let v = UIView()
        return v
    }()
    
    let header = BaseHeaderDetailMovieView()
    let footer = BaseFooterDetailMovieView()
    
    var movieTrailer: mVideoMovie?
    var movieHeaderSection: mDiscoveryMovie? {
        didSet {
            let backdrop = movieHeaderSection?.backdropPath ?? ""
            let stateVideo = movieTrailer != nil ? true : false
            header.imgHeader.setBackdrop(backdrop)
            header.btnPlay.isHidden = stateVideo == true ? false : true
            header.stateBackDrop(backdrop, stateVideo)
            
            let posterPath = movieHeaderSection?.posterPath ?? ""
            if posterPath == "" {
                imgCover.image = .imgGenre
            } else {
                imgCover.setImage(posterPath)
            }
            lblRuntime.text = convertToRuntim(time: movieHeaderSection?.runtime ?? 0)
            lblTitle.text = movieHeaderSection?.title ?? ""
            let released = movieHeaderSection?.releaseDate ?? ""
            lblDateReleased.text = released == "" ? "Coming Soon" : released.convertDates()
            containerAdult.isHidden = movieHeaderSection?.adult == true ? false : true
            
            footer.lblRating.setTitle("\(movieHeaderSection?.voteAverage.rounded(toPlaces: 1) ?? 0.0)")
            footer.valVoteCount.text = movieHeaderSection?.voteCount?.formattedWithSeparator ?? "0"
        }
    }
    
    override func setupViews() {
        super.setupViews()
        selectionStyle = .none
        backgroundColor = .bgSoftBlue
        
        [svHeader, footer].forEach { contentView.addSubview($0)
            contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: $0)
        }
        contentView.addConstraintsWithFormat(format: "V:|[v0][v1]-12-|", views: svHeader, footer)
        [header, container].forEach { svHeader.addArrangedSubview($0) }
        
        [imgCover, containerValue].forEach { container.addSubview($0)}
        container.addConstraintsWithFormat(format: "V:|->=12-[v0]->=12-|", views: imgCover)
        container.addConstraintsWithFormat(format: "V:|-12-[v0]-12-|", views: containerValue)
        imgCover.centerYAnchor(centerY: container.centerYAnchor)
        container.addConstraintsWithFormat(format: "H:|-16-[v0]-12-[v1]-16-|", views: imgCover, containerValue)
        
        containerValue.addSubview(svTitle)
        containerValue.addConstraintsWithFormat(format: "H:|[v0]|", views: svTitle)
        containerValue.addConstraintsWithFormat(format: "V:|[v0]->=12-|", views: svTitle)
        
        [lblTitle, lblRuntime, lblDateReleased, containerAdult].forEach { svTitle.addArrangedSubview($0) }
        containerAdult.addSubview(imgAdult)
        containerAdult.addConstraintsWithFormat(format: "V:|-4-[v0]|", views: imgAdult)
        containerAdult.addConstraintsWithFormat(format: "H:|[v0]->=0-|", views: imgAdult)
    }
    
    func convertToRuntim(time: Int) -> String {
        let hh = time / 60
        let mm = time - (hh * 60)
        let runtimeStr = hh > 0 ? "\(hh)h \(mm)m" : "\(time)m"
        return "Duration: \(runtimeStr)"
    }
}
