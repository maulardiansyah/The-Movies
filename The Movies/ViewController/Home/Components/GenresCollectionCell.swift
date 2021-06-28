//
//  GenresCollectionCell.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class GenresCollectionCell: BaseCollectionViewCell
{
    let img: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.image = .imgGenre
        v.widthAnchor.constraint(equalToConstant: 40).isActive = true
        v.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return v
    }()
    
    let name: UILabel = {
        let v = UILabel()
        v.numberOfLines = 0
        v.textAlignment = .center
        v.textColor = .darkBlue
        v.font = .system(.xsmall, weight: .semibold)
        v.adjustsFontSizeToFitWidth = true
        return v
    }()
    
    let svContent: UIStackView = {
        let v = UIStackView()
        v.spacing = 8
        v.axis = .vertical
        v.distribution = .fill
        return v
    }()
    
    let container: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 8
        return v
    }()
    
    var menu: mGenre? {
        didSet {
            name.text = menu?.name ?? ""
            name.sizeToFit()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(container)
        container.addSubview(svContent)
        [img, name].forEach { svContent.addArrangedSubview($0) }
        
        container.addConstraintsWithFormat(format: "H:|-6-[v0]-6-|", views: svContent)
        svContent.centerYAnchor(centerY: container.centerYAnchor)
        
        addConstraintsWithFormat(format: "H:|-[v0(100)]-|", views: container)
        addConstraintsWithFormat(format: "V:|-10-[v0(100)]-10-|", views: container)
    }
}
