//
//  MainController.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//
import UIKit

class MainController: UINavigationController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewControllers = [MainTabbarController()]
    }
}
