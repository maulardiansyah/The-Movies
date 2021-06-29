//
//  DetailSectionInfoCell.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

enum eInfoDetailSection {
    case overview
    case genre
    case status
    case budget
    case revenue
    
    var text: String {
        switch self {
        case .overview:
            return "Overview:"
        case .genre:
            return "Genre:"
        case .status:
            return "Status:"
        case .budget:
            return "Budget:"
        case .revenue:
            return "Revenue:"
        }
    }
}

class DetailSectionInfoCell: BaseTableViewCell
{
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .system(.normal, weight: .semibold)
        lbl.textColor = .darkBlue
        lbl.text = "Information"
        return lbl
    }()
    
    let svSectionInfo: UIStackView = {
        let v = UIStackView()
        v.spacing = 16
        v.axis = .vertical
        v.distribution = .fill
        return v
    }()
    
    let sectionInfoData: [eInfoDetailSection] = [.overview, .genre, .status, .budget, .revenue]
    
    var movieInfo: mDiscoveryMovie? {
        didSet {
            if let info = movieInfo {
                for i in sectionInfoData {
                    let view = setupSection(i, info)
                    svSectionInfo.addArrangedSubview(view)
                }
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        selectionStyle = .none
        backgroundColor = .white
        
        [lblTitle, svSectionInfo].forEach { contentView.addSubview($0)
            contentView.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: $0)
        }
        contentView.addConstraintsWithFormat(format: "V:|-12-[v0]-16-[v1]-16-|", views: lblTitle, svSectionInfo)
    }
    
    func setupSection(_ section: eInfoDetailSection, _ movieInfo: mDiscoveryMovie) -> BaseView {
        let view = LabelWithTitle()
        let title = section.text
        switch section {
        case .overview:
            view.setLabel(title, movieInfo.overview ?? "")
        case .status:
            view.setLabel(title, movieInfo.status ?? "")
        case .genre:
            view.setLabel(title, setGenre(movieInfo))
        case .budget:
            view.setLabel(title, "$ \(movieInfo.budget?.formattedWithSeparator ?? "0")")
        default:
            view.setLabel(title, "$ \(movieInfo.revenue?.formattedWithSeparator ?? "0")")
        }
        
        return view
    }
    
    func setGenre(_ movie: mDiscoveryMovie) -> String {
        var arrGenreTemp = [String]()
        for i in movie.genres ?? [] {
            arrGenreTemp.append(i.name ?? "")
        }
        return arrGenreTemp.joined(separator: ", ")
    }
}
