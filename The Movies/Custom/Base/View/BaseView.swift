//
//  BaseView.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class BaseView: UIView
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() { }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

