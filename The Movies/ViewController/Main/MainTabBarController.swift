//
//  MainTabBarController.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

class MainTabbarController: UITabBarController
{
    /// Index VC
    private var iSelected = 0
    private var iHome = 0
    private var iSearch = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        
        viewControllers = [
            setTabbarItem(vc: HomeGenreVC(), img: .home, imgSelected: .homeSelected),
            setTabbarItem(vc: SearchMoviesRouter.createModule(), img: .search, imgSelected: .searchSelected),
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /// remove title on back button
        navigationItem.title = " "
    }
    
    private func setTabbarItem(vc: UIViewController, title: String = "", img: UIImage?, imgSelected: UIImage?) -> UIViewController {
        let nav = vc
        nav.tabBarItem.title = nil
        nav.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        nav.tabBarItem.image = img?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = imgSelected?.withRenderingMode(.alwaysOriginal)
        
        return nav
    }
}

extension MainTabbarController: UITabBarControllerDelegate
{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let items = tabBar.items {
            items.enumerated().forEach { if $1 == item { updateIndicator($0) } }
        }
    }
    
    private func updateIndicator(_ i: Int) {
        /// Home is active and pressed again
        if i == iSearch, i == iSelected {
            selectedAgain()
        }
        
        iSelected = i
    }
    
    private func selectedAgain() {
        switch iSelected {
        case iSearch:
            if let clas = viewControllers?[iSelected] as? SearchMovieView {
                clas.scrollToTop()
            }
        default:
            return
        }
    }
}
