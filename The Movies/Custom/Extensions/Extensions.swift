//
//  Extensions.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

extension UIView
{
    func centerXYAnchor(centerX: NSLayoutXAxisAnchor, centerY: NSLayoutYAxisAnchor) {
        self.centerXAnchor(centerX: centerX)
        self.centerYAnchor(centerY: centerY)
    }
    
    func centerXAnchor(centerX: NSLayoutXAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: centerX).isActive = true
    }
    
    func centerYAnchor(centerY: NSLayoutYAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: centerY).isActive = true
    }
    
    func anchorSize(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        self.anchor(top: self.superview?.topAnchor, bottom: self.superview?.bottomAnchor, leading: self.superview?.leadingAnchor, trailing: self.superview?.trailingAnchor, padding: padding)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let t = top {
            self.topAnchor.constraint(equalTo: t, constant: padding.top).isActive = true
        }
        if let b = bottom {
            self.bottomAnchor.constraint(equalTo: b, constant: -padding.bottom).isActive = true
        }
        if let l = leading {
            self.leadingAnchor.constraint(equalTo: l, constant: padding.left).isActive = true
        }
        if let r = trailing {
            self.trailingAnchor.constraint(equalTo: r, constant: -padding.right).isActive = true
        }
    }
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
