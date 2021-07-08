//
//  BaseView.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class BaseView: UIView
{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setupViews()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() { }
}

