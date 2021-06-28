//
//  TableView+Extensions.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

extension UITableView
{
    func setEmptyView(img: UIImage?, title: String, desc: String, descColor: UIColor = .gray) {
        let bg = BaseEmptyStateView()
        bg.sizeToFit()
        bg.img.image = img
        bg.judul.text = title
        bg.desc.text = desc
        bg.desc.textColor = descColor
        self.backgroundView = bg
    }
    
    func removeEmptyView() {
        self.backgroundView = nil
    }
}
