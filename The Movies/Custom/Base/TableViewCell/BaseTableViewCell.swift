//
//  BaseTableViewCell.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class BaseTableViewCell: UITableViewCell
{
    let container: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.clipsToBounds = true
        return v
    }()
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.8 : 1.0
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setupViews()
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
