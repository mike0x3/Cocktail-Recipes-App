//
//  FilmCell.swift
//  Cocktail Zoo
//
//  Created by Mikhaylo Chornenkiy on 26.12.21.
//

import UIKit
import SkeletonView

class CocktailCell: UICollectionViewCell {
    
    let strokeTextAttributes: [NSAttributedString.Key : Any] = [
        .strokeColor : UIColor.black,
        .foregroundColor : UIColor.white,
        .strokeWidth : -2.0,
        .font : UIFont(name: "HelveticaNeue-Bold", size: 17)!
        ]
    
    var data: Cocktail? {
        didSet {
            guard let data = data else { return }
            let urlString = data.strDrinkThumb.replacingOccurrences(of: "\\", with: "")
            let url = URL(string: urlString)
            let imageData = try? Data(contentsOf: url!)
            cocktailImage.image = UIImage(data: imageData!)
            cocktailNameLabel.attributedText = NSAttributedString(string: data.strDrink, attributes: strokeTextAttributes)
        }
    }
    
    let cocktailNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cocktailImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    let cellView: UIView = {
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 255/255)
        cellView.layer.cornerRadius = 15
        cellView.layer.masksToBounds = false
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 1
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowRadius = 10
        return cellView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.isSkeletonable = true
        cellView.isSkeletonable = true
        cocktailImage.isSkeletonable = true
        //cocktailNameLabel.isSkeletonable = true
        
        contentView.addSubview(cellView)
        cocktailImage.addSubview(cocktailNameLabel)
        cellView.addSubview(cocktailImage)
        cocktailImage.bringSubviewToFront(cocktailNameLabel)
    
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            cellView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cocktailNameLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -15),
            cocktailNameLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            
            cocktailImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            cocktailImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            cocktailImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            cocktailImage.topAnchor.constraint(equalTo: cellView.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
