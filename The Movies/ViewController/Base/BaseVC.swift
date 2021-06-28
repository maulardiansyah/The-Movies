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
    
    let safeview: UIView = {
        let v = UIView()
        v.backgroundColor = .bgWhite
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
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func tabbarPush(vc: UIViewController) {
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tabbarPresent(vc: UIViewController, fullscreen: Bool = false) {
        if(fullscreen) {
            //Disable the interactive dismissal & set fullscreen in iOS 13
            if #available(iOS 13.0, *) {
                vc.modalPresentationStyle = .fullScreen
            }
        }
        
        tabBarController?.present(vc, animated: true, completion: nil)
    }
    
    func toRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func toPrev() {
        navigationController?.popViewController(animated: true)
    }
    
    func toPrev(vc: AnyClass) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: vc) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            } else {
                toPrev()
            }
        }
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
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            let tabbar = tabBarController?.tabBar.frame.height ?? 0
            let bottomPadding = Helper.getBottomPadding()

            bottomConstraint?.constant = isKeyboardShowing ? -(keyboardFrame.height - tabbar - bottomPadding) : 0
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func tabbar(isHidden: Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    
    func alertInfo(_ title: String = "", msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.alertAction()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func alertInfoWarn(_ title: String = "", msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func alertInfoWithCancel(_ title: String = "", msg: String, ok: String = "OK") {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: ok, style: .default, handler: { action in
            self.alertAction()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func alertAction() { }
    
    func getVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "no version info"
    }
    
    @objc func refreshAction() {
        refreshControl.endRefreshing()
    }
    
    @objc func buttonPressed(_ sender: UIButton) { }
    
    func hide(views: [UIView], _ flag: Bool = true) {
        views.forEach { $0.isHidden = flag }
    }
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


