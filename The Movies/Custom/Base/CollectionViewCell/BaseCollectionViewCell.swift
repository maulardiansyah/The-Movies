//
//  BaseCollectionViewCell.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.8 : 1.0
        }
    }
    
    func setupViews() { }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
