//
//  ListMovieCell.swift
//  The Movies
//
//  Created by Maul on 07/07/21.
//

import UIKit

class ListMovieCell: UITableViewCell {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblReleasedDate: UILabel!
    @IBOutlet weak var lblTitleMovie: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var separator: UIView!
    
    static let identifier = "movieListCell"
    
    static func movieCellNib() -> UINib {
        return UINib(nibName: "ListMovieCell", bundle: nil)
    }

    func setValueCell(_ poster: String, _ title: String, _ released: String, _ rating: Double) {
        imgPoster.setImage(poster, placeholder: .imgGenre)
        lblTitleMovie.text = title
        lblReleasedDate.text = released == "" ? "Coming Soon" : released
        lblRating.text = "\(rating)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        setupImgPoster()
        setupLabel()
        separator.backgroundColor = .grayStroke
    }
    
    //MARK: - Connfigure View
    func setupImgPoster() {
        imgPoster.backgroundColor = .bgSoftBlue
        imgPoster.layer.cornerRadius = 8
    }
    
    func setupLabel() {
        lblTitleMovie.textColor = .darkBlue
        lblReleasedDate.textColor = .gray
        lblRating.textColor = .gray
    }
}
