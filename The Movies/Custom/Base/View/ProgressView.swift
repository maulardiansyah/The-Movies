//
//  ProgressView.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

public class ProgressView
{
    let container: UIView = {
        let v = UIView()
        return v
    }()
    
    let indicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        return v
    }()
    
    public class var shared: ProgressView {
        struct Static {
            static let instance: ProgressView = ProgressView()
        }
        return Static.instance
    }
    
    public func show(view: UIView, backgroundColor: UIColor = UIColor.white.withAlphaComponent(0.7), style : UIActivityIndicatorView.Style = .whiteLarge) {
        view.addSubview(container)
        container.backgroundColor = backgroundColor
        container.anchorSize(to: view)
        
        setupIndicator(style)
    }
    
    public func setupIndicator(_ style: UIActivityIndicatorView.Style, _ color: UIColor = .green) {
        indicator.style = style
        indicator.color = color
        indicator.startAnimating()
        container.addSubview(indicator)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor(centerX: container.centerXAnchor)
        indicator.centerYAnchor(centerY: container.centerYAnchor)
        indicator.widthAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        indicator.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
    }
    
    public func hide() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        container.removeFromSuperview()
    }
}
