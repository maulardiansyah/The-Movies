//
//  LabelWithLeftImage.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class LabelWithLeftImage: BaseView
{
    let leftImage: UIButton = {
        let v = UIButton()
        v.clipsToBounds = true
        v.imageView?.contentMode = .scaleAspectFit
        v.isUserInteractionEnabled = false
        return v
    }()
    
    let title: UILabel = {
        let v = UILabel()
        v.font = .system(.small, weight: .regular)
        v.textColor = .white
        v.numberOfLines = 0
        return v
    }()
    
    var leftImageHeight: CGFloat? {
        didSet {
            leftImage.heightAnchor.constraint(equalToConstant: leftImageHeight ?? 0).isActive = true
            setNeedsUpdateConstraints()
        }
    }
    
    var leftImageIsCenterVertical: Bool = false {
        didSet {
            if(leftImageIsCenterVertical) {
                leftImage.centerYAnchor(centerY: centerYAnchor)
                setNeedsUpdateConstraints()
            }
        }
    }
    
    var rightSpace: Int = 6
    
    override func setupViews() {
        addSubview(leftImage)
        addSubview(title)
        
        addConstraintsWithFormat(format: "V:|[v0]-(>=0)-|", views: leftImage)
        addConstraintsWithFormat(format: "V:|[v0]|", views: title)
        addConstraintsWithFormat(format: "H:|[v0]-(\(rightSpace))-[v1]|", views: leftImage, title)
        leftImage.widthAnchor.constraint(equalTo: leftImage.heightAnchor, multiplier: 1).isActive = true
    }
    
    func setLeftImage(_ img: UIImage?) {
        leftImage.setImage(img, for: .normal)
    }
    
    func setLeftImage(inset: UIEdgeInsets) {
        leftImage.imageEdgeInsets = inset
    }
    
    func setTitle(_ text: String) {
        title.text = text
    }
    
    func setTitleColor(_ color: UIColor) {
        title.textColor = color
    }
    
    func setTintColor(_ color: UIColor) {
        leftImage.tintColor = color
    }
    
    func setFont(_ font: UIFont) {
        title.font = font
    }
    
    func numberLines(line: Int) {
        title.numberOfLines = line
    }
}
