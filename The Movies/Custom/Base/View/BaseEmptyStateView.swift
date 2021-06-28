//
//  BaseEmptyStateView.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class BaseEmptyStateView: BaseView
{
    let img: UIImageView = {
        let v = UIImageView()
        v.backgroundColor = .clear
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    let judul: UILabel = {
        let v = UILabel()
        v.textColor = .darkBlue
        v.font = .system(.normal, weight: .semibold)
        v.text = "Title"
        v.textAlignment = .center
        v.numberOfLines = 0
        return v
    }()
    
    let desc: UILabel = {
        let v = UILabel()
        v.textColor = .green
        v.font = .system(.normal)
        v.text = "Deskripsi"
        v.textAlignment = .center
        v.numberOfLines = 0
        return v
    }()
    
    var heightImg: CGFloat = 160 {
        didSet {
            img.heightAnchor.constraint(equalToConstant: heightImg).isActive = true
        }
    }
    
    var widthImg: CGFloat = 128 {
        didSet {
            img.widthAnchor.constraint(equalToConstant: widthImg).isActive = true
        }
    }
    
    override func setupViews() {
        [img, judul, desc].forEach {
            addSubview($0)
        }
        
        addConstraintsWithFormat(format: "V:|-(>=100)-[v0]-(16)-[v1]-[v2]-(>=8)-|", views: img, judul, desc)
        img.centerYAnchor(centerY: centerYAnchor)
        addConstraintsWithFormat(format: "H:|-(16)-[v0]-(16)-|", views: judul)
        addConstraintsWithFormat(format: "H:|-(16)-[v0]-(16)-|", views: desc)
        [img, judul, desc].forEach { $0.centerXAnchor(centerX: self.centerXAnchor) }
    }
}
