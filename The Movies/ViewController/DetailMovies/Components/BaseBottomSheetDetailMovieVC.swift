//
//  BaseBottomSheetDetailMovieVC.swift
//  The Movies
//
//  Created by Maul on 29/06/21.
//

import UIKit
import FittedSheets

class BaseBottomSheetDetailMovieVC: BaseVC
{
    let userReview = BottomSheetReviewDetailVC()
    let viewVideo = BottomSheetPlayVideoDetailVC()
    
    var kode = 0
    var movieId = 0
    
    var pathVideo = ""
    
    var sheet = SheetViewController(controller: UIViewController())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch kode {
        case 0:
            setValueReview()
        default:
            setValueViewVideo()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSheet()
    }
    
    func setupSheet() {
        let sheetOption = SheetOptions(pullBarHeight: 0, cornerRadius: 8, useInlineMode: true)
        sheet = SheetViewController(controller: checkKode(), sizes: [.percent(sizeSheet())], options: sheetOption)

        sheet.willMove(toParent: self)
        self.addChild(sheet)
        safeview.addSubview(sheet.view)
        sheet.didMove(toParent: self)
        /// Constraint
        sheet.view.translatesAutoresizingMaskIntoConstraints = false
        sheet.view.fillSuperview()
        /// animate in
        sheet.animateIn()
        sheet.didDismiss = { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupDismiss() {
        sheet.animateOut(duration: 0.3) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    override func setupViews() {
        super.setupViews()

        view.backgroundColor = .black.withAlphaComponent(0.5)
        statusbar.backgroundColor = .clear
        safeview.backgroundColor = .clear
        bottombar.backgroundColor = .white
    }
    
    func setValueReview() {
        userReview.movieId = movieId
        
        userReview.actionClose = {
            self.setupDismiss()
        }
    }
    
    func setValueViewVideo() {
        viewVideo.pathLink = pathVideo
        
        viewVideo.actionClose = {
            self.setupDismiss()
        }
    }
    
    func checkKode() -> BaseVC {
        switch kode {
        case 0:
            return userReview
        default:
            return viewVideo
        }
    }
    
    func sizeSheet() -> Float {
        switch kode {
        case 0:
            return 0.8
        default:
            return 0.5
        }
    }
}
