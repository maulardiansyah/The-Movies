//
//  LabelWithTitle.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class LabelWithTitle: BaseView
{
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.small, weight: .semibold)
        return lbl
    }()
    
    let lblValue: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.small)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func setupViews() {
        super.setupViews()
        
        [lblTitle, lblValue].forEach { addSubview($0)
            addConstraintsWithFormat(format: "H:|[v0]|", views: $0)
        }
        addConstraintsWithFormat(format: "V:|[v0]-8-[v1]|", views: lblTitle, lblValue)
    }
    
    func setLabel(_ title: String, _ desc: String) {
        lblTitle.text = title
        lblValue.text = desc
    }
}
