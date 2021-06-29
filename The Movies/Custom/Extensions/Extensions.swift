//
//  Extensions.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit
import Toast_Swift

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
    
    func showToast(_ message: String, duration: TimeInterval = 2.0, position: ToastPosition = .bottom, bgColor: UIColor = UIColor.black.withAlphaComponent(0.8)) {
        var style = ToastStyle()
        style.backgroundColor = bgColor
        self.makeToast(message, duration: duration, position: position, style: style)
    }
}

extension UIImageView
{
    func setImage(_ path: String, placeholder: UIImage? = nil) {
        if let url = URL(string: "https://www.themoviedb.org/t/p/w440_and_h660_face\(path)") {
            self.contentMode = .scaleAspectFill
            self.clipsToBounds = true
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: url,
                placeholder: placeholder,
                options: [.transition(.fade(1))],
                progressBlock: nil,
                completionHandler: { result in })
        }
    }
    
    func setBackdrop(_ path: String, placeholder: UIImage? = nil) {
        if let url = URL(string: "https://www.themoviedb.org/t/p/w1066_and_h600_bestv2\(path)") {
            self.contentMode = .scaleAspectFill
            self.clipsToBounds = true
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: url,
                placeholder: placeholder,
                options: [.transition(.fade(1))],
                progressBlock: nil,
                completionHandler: { result in })
        }
    }
}

extension Double
{
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

extension String {
    func datePrefixTimezone() -> String {
        return "\(self.prefix(10))"
    }
}
