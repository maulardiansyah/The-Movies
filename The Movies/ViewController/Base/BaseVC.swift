//
//  BaseVC.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit
import ImageSlideshow

class BaseVC: UIViewController
{
    var potraitConstraints: [NSLayoutConstraint] = []
    var landscapeConstraints: [NSLayoutConstraint] = []
    var bottomConstraint: NSLayoutConstraint?
    
    let statusbar: UIView = {
        let v = UIView()
        return v
    }()
    
    let bottombar: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    /// Navigation View
    let navview: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    let navTitle: UILabel = {
        let v = UILabel()
        v.textColor = .darkBlue
        v.font = UIFont.system(.medium, weight: .semibold)
        return v
    }()
    
    let navBtLeft: UIButton = {
        let v = UIButton()
        v.tintColor = .darkBlue
        v.imageView?.contentMode = .scaleAspectFit
        v.setImage(.btBack, for: .normal)
        return v
    }()
    
    let safeview: UIView = {
        let v = UIView()
        v.backgroundColor = .bgSoftBlue
        return v
    }()
    
    let scrollview: UIScrollView = {
        let v = UIScrollView()
        v.alwaysBounceVertical = true
        v.showsVerticalScrollIndicator = false
        return v
    }()
    
    let container: UIView = {
        let v = UIView()
        return v
    }()
    
    let innerScrollview: UIView = {
        let v = UIView()
        return v
    }()
    
    let refreshControl: UIRefreshControl = {
        let v = UIRefreshControl()
        v.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return v
    }()
    
    let progressView = ProgressView()
    
    var m16: CGFloat = 16
    var leftRightMargin: CGFloat = 0
    
    let formS: CGFloat = 32
    let formM: CGFloat = 42
    let formL: CGFloat = 52
    
    var titleText = ""
    var subtitleText = ""
    var isLoading: Bool = false
    
    var prevVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeview.backgroundColor = .bgSoftBlue
        
        setNavigation()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation(isHidden: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        /// remove title on back button
        navigationItem.title = " "
    }
    
    func setTitle(_ title: String, subtitle: String = "", titleColor: UIColor = .darkBlue) {
        let navbarH = self.navigationController?.navigationBar.frame.height ?? 0
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: navbarH))
        label.textAlignment = .left
        label.text = title
        label.numberOfLines = 0
        label.textColor = titleColor
        
        let attributText = NSMutableAttributedString()
        
        var boldText = "\(title)"
        if(subtitle != ""){ boldText += "\n" }
        let boldAttrs = [NSAttributedString.Key.font : UIFont.system(.medium, weight: .semibold)]
        let boldAttributedString = NSMutableAttributedString(string:boldText, attributes:boldAttrs as [NSAttributedString.Key : Any])
        
        let normalText = "\(subtitle)"
        let normalAttrs = [NSAttributedString.Key.font : UIFont.system(.small, weight: .light)]
        let normalAttributedString = NSMutableAttributedString(string:normalText, attributes:normalAttrs as [NSAttributedString.Key : Any])
        
        attributText.append(boldAttributedString)
        attributText.append(normalAttributedString)
        
        label.attributedText = attributText
        navigationItem.titleView = label
    }
    
    func setBackButton(isHidden: Bool) {
        navigationItem.hidesBackButton = isHidden
    }
    
    func setNavigation(barTintColor: UIColor = .white, tintColor: UIColor = .darkBlue) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = barTintColor
        navigationController?.navigationBar.tintColor = tintColor
        
        /// set default back button is show
        setBackButton(isHidden: false)
    }
    
    func setNavigation(isHidden: Bool, animated: Bool = false) {
        navigationController?.setNavigationBarHidden(isHidden, animated: animated)
    }
    
    func setNavigationLeftButtons(titles: [String], icons: [UIImage?]) {
        var lh = [UIBarButtonItem?](repeating: nil, count: titles.count)
        for i in 0 ..< lh.count {
            if icons.count > 0 {
                lh[i] = UIBarButtonItem(image: icons[i]?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(leftButtonPressed(sender:)))
                lh[i]?.title = titles[i]
            } else {
                lh[i] = UIBarButtonItem(title: titles[i], style: .plain, target: self, action: #selector(leftButtonPressed(sender:)))
            }
        }
        navigationItem.leftBarButtonItems = lh as? [UIBarButtonItem]
    }
    
    @objc func leftButtonPressed(sender : UIBarButtonItem) { }
    
    func toNext(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func toPresent(vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    
    func toRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func toPrev() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        view.addSubview(statusbar)
        view.addSubview(safeview)
        view.addSubview(bottombar)
        
        /// pull to refresh
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    func setupConstraints() {
        if #available(iOS 11.0, *) {
            let sf = view.safeAreaLayoutGuide
            statusbar.anchor(top: view.topAnchor, bottom: sf.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .zero)
            safeview.anchor(top: sf.topAnchor, bottom: nil, leading: sf.leadingAnchor, trailing: sf.trailingAnchor, padding: .zero)
            bottombar.anchor(top: sf.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .zero)
            bottomConstraint = NSLayoutConstraint(item: safeview, attribute: .bottom, relatedBy: .equal, toItem: sf, attribute: .bottom, multiplier: 1, constant: 0)
        } else {
            let sf = view
            statusbar.anchor(top: view.topAnchor, bottom: sf?.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .zero)
            safeview.anchor(top: sf?.topAnchor, bottom: nil, leading: sf?.leadingAnchor, trailing: sf?.trailingAnchor, padding: .zero)
            bottombar.anchor(top: sf?.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .zero)
            bottomConstraint = NSLayoutConstraint(item: safeview, attribute: .bottom, relatedBy: .equal, toItem: sf, attribute: .bottom, multiplier: 1, constant: 0)
        }
        view.addConstraint(bottomConstraint!)
    }
    
    private func anchor() { }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("\(getClassName()) \(#function)")
    }
    
    func getClassName() -> String {
        return String(describing: classForCoder)
    }
    
    func tabbar(isHidden: Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    
    @objc func refreshAction() {
        refreshControl.endRefreshing()
    }
    
    @objc func buttonPressed(_ sender: UIButton) { }
}

//MARK:- Show Fullscreen Image
extension BaseVC
{
    public func toFullScreenImage(urlString: [String], index: Int = 0) {
        var sources = [InputSource]()
        for i in 0..<urlString.count {
            if let url = URL(string: urlString[i]) {
                sources.append(KingfisherSource(url: url))
            }
        }
        
        /// Cek count of source before show up
        if sources.count > 0 {
            let full = FullScreenSlideshowViewController()
            full.inputs = sources
            full.initialPage = index
            full.modalTransitionStyle = .crossDissolve
            present(full, animated: true, completion: nil)
        } else {
            view.showToast("Image can't fullscreen")
        }
    }
}


