//
//  CocktailTableViewCell.swift
//  Cocktail Zoo
//
//  Created by Mikhaylo Chornenkiy on 07.01.22.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {
    
    var data: Cocktail? {
        didSet {
            //MARK: Remember to set the default data in case the image wouldnt work to avoid app crash
            guard let data = data else { return }
            let urlString = data.strDrinkThumb.replacingOccurrences(of: "\\", with: "")
            let url = URL(string: urlString)
            let imageData = try? Data(contentsOf: url!)
            if let imageData = imageData {
                cocktailImage.image = UIImage(data: imageData)
            } else {
                cocktailImage.image = UIImage(named: "sorry")
            }
            cocktailTitle.text = data.strDrink
            alcoholLabel.text = data.strAlcoholic
            categoryLabel.text = data.strCategory
            if data.strAlcoholic == "Non alcoholic" {
                alcoholImage.image = UIImage(systemName: "car.fill")
            } else {
                alcoholImage.image = UIImage(systemName: "figure.walk")
            }
        }
    }
    
    let cocktailImage: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let cocktailTitle: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont(name: "Georgia-Bold", size: 20)!
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let alcoholImage: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let alcoholLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        l.font = UIFont(name: "Georgia-Bold", size: 14)!
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let categoryImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "category")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let categoryLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        l.font = UIFont(name: "Georgia-Bold", size: 14)!
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let cellView: UIView = {
            let v = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 140))
            v.backgroundColor = UIColor.init(red: 43/255, green: 43/255, blue: 43/255, alpha: 43/255)
            v.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 255/255)
            v.layer.cornerRadius = 15
            v.layer.masksToBounds = false
            v.layer.shadowColor = UIColor.black.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowOffset = .zero
            v.layer.shadowRadius = 5
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        contentView.addSubview(cellView)
        cellView.addSubview(cocktailImage)
        cellView.addSubview(cocktailTitle)
        cellView.addSubview(alcoholImage)
        cellView.addSubview(alcoholLabel)
        cellView.addSubview(categoryImage)
        cellView.addSubview(categoryLabel)
        
        contentView.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 255/255)
        
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            cocktailImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            cocktailImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            cocktailImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            cocktailImage.widthAnchor.constraint(equalToConstant: 80),
            
            cocktailTitle.topAnchor.constraint(equalTo: cocktailImage.topAnchor, constant: 5),
            cocktailTitle.leadingAnchor.constraint(equalTo: cocktailImage.trailingAnchor, constant: 8),
            
            alcoholImage.topAnchor.constraint(equalTo: cocktailTitle.bottomAnchor, constant: 5),
            alcoholImage.leadingAnchor.constraint(equalTo: cocktailImage.trailingAnchor, constant: 8),
            alcoholImage.widthAnchor.constraint(equalToConstant: 15),
            alcoholImage.heightAnchor.constraint(equalToConstant: 15),
            
            alcoholLabel.topAnchor.constraint(equalTo: alcoholImage.topAnchor),
            alcoholLabel.leadingAnchor.constraint(equalTo: alcoholImage.trailingAnchor, constant: 5),
            
            categoryImage.topAnchor.constraint(equalTo: alcoholLabel.bottomAnchor, constant: 5),
            categoryImage.leadingAnchor.constraint(equalTo: cocktailImage.trailingAnchor, constant: 8),
            categoryImage.widthAnchor.constraint(equalToConstant: 15),
            categoryImage.heightAnchor.constraint(equalToConstant: 15),
            
            categoryLabel.topAnchor.constraint(equalTo: categoryImage.topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: 5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
