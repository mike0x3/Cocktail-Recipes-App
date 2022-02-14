//
//  IngredientCell.swift 
//  Cocktail Zoo
//
//  Created by Mikhaylo Chornenkiy on 29.12.21.
//

import UIKit

class IngredientCell: UICollectionViewCell {
    
    let strokeTextAttributes: [NSAttributedString.Key : Any] = [
        .strokeColor : UIColor.black,
        .foregroundColor : UIColor.white,
        .strokeWidth : -2.0,
        .font : UIFont(name: "HelveticaNeue-Bold", size: 16)!
        ]
    
    var data: Ingredient? {
        didSet {
            guard let data = data else { return }
            let urlString = data.imageURL
            let url = URL(string: urlString)
            let imageData = try? Data(contentsOf: url!)
            if let imageData = imageData {
                ingredientImage.image = UIImage(data: imageData)
            } else {
                ingredientImage.image = UIImage(named: "sorry")
            }
            ingredientNameLabel.attributedText = NSAttributedString(string: data.name, attributes: strokeTextAttributes)
            measureLabel.attributedText = NSAttributedString(string: data.measure, attributes: strokeTextAttributes)
        }
    }
    
    let ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let measureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ingredientImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    let cellView: UIView = {
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 160))
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 255/255)
        cellView.layer.cornerRadius = 15
        cellView.layer.masksToBounds = false
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 1
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowRadius = 5
        return cellView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(cellView)
        cellView.addSubview(ingredientImage)
        cellView.addSubview(ingredientNameLabel)
        cellView.addSubview(measureLabel)
        ingredientImage.bringSubviewToFront(ingredientNameLabel)
        ingredientImage.bringSubviewToFront(measureLabel)
    
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            cellView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            ingredientNameLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -20),
            ingredientNameLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            
            measureLabel.topAnchor.constraint(equalTo: ingredientNameLabel.bottomAnchor, constant: -2),
            measureLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            
            ingredientImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8),
            ingredientImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            ingredientImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            ingredientImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
