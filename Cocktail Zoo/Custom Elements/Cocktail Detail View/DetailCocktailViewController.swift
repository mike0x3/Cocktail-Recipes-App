//
//  DetailViewController.swift
//  Cocktail Zoo
//
//  Created by Mikhaylo Chornenkiy on 27.12.21.
//

import UIKit

class DetailCocktailViewController: UIViewController {
    
    
    var item: Cocktail? {
        didSet {
            guard let item = item else { return }
            let urlString = item.strDrinkThumb.replacingOccurrences(of: "\\", with: "")
            let url = URL(string: urlString)
            let imageData = try? Data(contentsOf: url!)
            if let imageData = imageData {
                cocktailImage.image = UIImage(data: imageData)
            } else {
                cocktailImage.image = UIImage(named: "sorry")
            }
            cocktailNameLabel.text = item.strDrink
            alcoholLabel.text = item.strAlcoholic
            if item.strAlcoholic == "Non alcoholic" {
                alcoholImage.image = UIImage(systemName: "car.fill")
            } else {
                alcoholImage.image = UIImage(systemName: "figure.walk")
            }
            glassLabel.text = item.strGlass
            categoryLabel.text = item.strCategory
            ibaLabel.text = item.strIBA
            instructionTextView.text = item.strInstructions
        }
    }
    
    var cocktailSaved: Bool = false
    
    var ingredientsList: Ingredients = .init(ingredientsList: [])
    
    var instructionLanguagesList: [String] = []
    var instructionList: [String] = []
    
    var favouriteCocktails: [Cocktail] = []
    
    var collectionView: UICollectionView! = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var addToFavouritesButton: UIImage = {
        let b = UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return b!
    }()
    
    let cocktailNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Georgia-Bold", size: 24)!
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
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
    
    let glassImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "glass")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let glassLabel: UILabel = {
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
    
    let ibaLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        l.font = UIFont(name: "Georgia-Bold", size: 14)!
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let ibaImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "waiter")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let cocktailImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.shadowColor = UIColor.white.cgColor
        iv.layer.shadowOpacity = 1
        iv.layer.shadowRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let ingredientsTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Ingredients"
        l.textColor = .white
        l.font = UIFont(name: "Georgia-Bold", size: 24)!
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let ingredientsFullPageButton: UIButton = {
        let b = UIButton()
        let buttonImage = UIImage(systemName: "arrow.forward")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        b.setImage(buttonImage, for: .normal)
        b.addTarget(self, action: #selector(scrollIngredients), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let instructionTitleLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont(name: "Georgia-Bold", size: 24)!
        l.text = "Preparation"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let instructionView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 255/255)
        v.layer.cornerRadius = 15
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let instructionTextView: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = true
        tv.isEditable = false
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 255/255)
        tv.textColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseInstructions(item: item!)
        
        let segmentedControl: UISegmentedControl = {
            let sc = UISegmentedControl(items: instructionLanguagesList)
            sc.selectedSegmentIndex = 0
            let frame = UIScreen.main.bounds
            sc.frame = CGRect(x: frame.minX + 10, y: frame.minY + 50, width: frame.width - 20, height: frame.height*0.1)
            sc.backgroundColor = UIColor.init(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            sc.addTarget(self, action: #selector(changeInstructionLanguage(sender:)), for: .valueChanged)
            sc.translatesAutoresizingMaskIntoConstraints = false
            //Changing the text color to be white in normal state and black when selected
            let whiteTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            let blackTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            UISegmentedControl.appearance().setTitleTextAttributes(whiteTextAttributes, for: .normal)
            UISegmentedControl.appearance().setTitleTextAttributes(blackTextAttributes, for: .selected)
            return sc
        }()
        
        view.backgroundColor = UIColor(red: 32/255, green: 33/255, blue: 36/255, alpha: 1)
        
        collectionView = {
            let layout: UICollectionViewFlowLayout = {
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.minimumLineSpacing = 20
                layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
                layout.itemSize = CGSize(width: 120, height: 160)
                layout.scrollDirection = .horizontal
                return layout
            }()
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(IngredientCell.self, forCellWithReuseIdentifier: "cell")
            collectionView.backgroundColor = UIColor(red: 32/255, green: 33/255, blue: 36/255, alpha: 1)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isSkeletonable = true
            //collectionView.isUserInteractionDisabledWhenSkeletonIsActive = false
            return collectionView
        }()
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addToFavouritesButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: addToFavouritesButton, style: .plain, target: self, action: #selector(addToFavourites))
    
        view.addSubview(cocktailNameLabel)
        view.addSubview(cocktailImage)
        
        view.addSubview(alcoholImage)
        view.addSubview(alcoholLabel)
        view.addSubview(glassImage)
        view.addSubview(glassLabel)
        view.addSubview(categoryImage)
        view.addSubview(categoryLabel)
        if let iba = item!.strIBA {
            view.addSubview(ibaImage)
            view.addSubview(ibaLabel)
            
            NSLayoutConstraint.activate([
                ibaImage.topAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: 7),
                ibaImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                ibaImage.heightAnchor.constraint(equalToConstant: 15),
                ibaImage.widthAnchor.constraint(equalToConstant: 15),
                
                ibaLabel.leadingAnchor.constraint(equalTo: ibaImage.trailingAnchor, constant: 5),
                ibaLabel.topAnchor.constraint(equalTo: ibaImage.topAnchor),
            ])
        }
        
        view.addSubview(ingredientsTitleLabel)
        view.addSubview(ingredientsFullPageButton)
        view.addSubview(collectionView)
        
        view.addSubview(instructionTitleLabel)
        view.addSubview(instructionView)
        
        instructionView.addSubview(segmentedControl)
        instructionView.addSubview(instructionTextView)
        instructionView.bringSubviewToFront(segmentedControl)
        instructionView.bringSubviewToFront(instructionTextView)
        
        NSLayoutConstraint.activate([
            
            cocktailNameLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 70),
            cocktailNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            cocktailNameLabel.widthAnchor.constraint(equalToConstant: 220),
            
            cocktailImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15),
            cocktailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            cocktailImage.widthAnchor.constraint(equalToConstant: 180),
            cocktailImage.heightAnchor.constraint(equalToConstant: 230),
            
            alcoholImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            alcoholImage.topAnchor.constraint(equalTo: cocktailNameLabel.bottomAnchor, constant: 17),
            alcoholImage.heightAnchor.constraint(equalToConstant: 15),
            alcoholImage.widthAnchor.constraint(equalToConstant: 15),
            
            alcoholLabel.topAnchor.constraint(equalTo: alcoholImage.topAnchor),
            alcoholLabel.leadingAnchor.constraint(equalTo: alcoholImage.trailingAnchor, constant: 5),
            
            glassImage.topAnchor.constraint(equalTo: alcoholImage.bottomAnchor, constant: 7),
            glassImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            glassImage.heightAnchor.constraint(equalToConstant: 15),
            glassImage.widthAnchor.constraint(equalToConstant: 15),
            
            glassLabel.topAnchor.constraint(equalTo: glassImage.topAnchor),
            glassLabel.leadingAnchor.constraint(equalTo: glassImage.trailingAnchor, constant: 5),
            
            categoryImage.topAnchor.constraint(equalTo: glassImage.bottomAnchor, constant: 7),
            categoryImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            categoryImage.heightAnchor.constraint(equalToConstant: 15),
            categoryImage.widthAnchor.constraint(equalToConstant: 15),
            
            categoryLabel.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: 5),
            categoryLabel.topAnchor.constraint(equalTo: categoryImage.topAnchor),
            
            ingredientsTitleLabel.topAnchor.constraint(equalTo: cocktailImage.bottomAnchor, constant: 12),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            ingredientsFullPageButton.topAnchor.constraint(equalTo: ingredientsTitleLabel.topAnchor, constant: 3),
            ingredientsFullPageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            ingredientsFullPageButton.heightAnchor.constraint(equalToConstant: 24),
            ingredientsFullPageButton.widthAnchor.constraint(equalToConstant: 24),
            
            collectionView.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: 7),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 180),
            
            instructionTitleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 7),
            instructionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            instructionView.topAnchor.constraint(equalTo: instructionTitleLabel.bottomAnchor, constant: 15),
            instructionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            instructionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            instructionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            
            segmentedControl.topAnchor.constraint(equalTo: instructionView.topAnchor, constant: 5),
            segmentedControl.leadingAnchor.constraint(equalTo: instructionView.leadingAnchor, constant: 5),
            segmentedControl.trailingAnchor.constraint(equalTo: instructionView.trailingAnchor, constant: -5),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            instructionTextView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 3),
            instructionTextView.leadingAnchor.constraint(equalTo: instructionView.leadingAnchor, constant: 3),
            instructionTextView.trailingAnchor.constraint(equalTo: instructionView.trailingAnchor, constant: -3),
            instructionTextView.bottomAnchor.constraint(equalTo: instructionView.bottomAnchor, constant: -3)
            
        ])
        print("We are about to load")
        loadFavouriteCocktails()
    }
    
    func parseInstructions(item: Cocktail) {
        if let instructionEN = item.strInstructions {
            self.instructionLanguagesList.append("🇺🇸English")
            self.instructionList.append(instructionEN)
        }
        if let instructionDE = item.strInstructionsDE {
            self.instructionLanguagesList.append("🇩🇪German")
            self.instructionList.append(instructionDE)
        }
        if let instructionES = item.strInstructionsES {
            self.instructionLanguagesList.append("🇪🇸Spanish")
            self.instructionList.append(instructionES)
        }
        if let instructionFR = item.strInstructionsFR {
            self.instructionLanguagesList.append("🇨🇵French")
            self.instructionList.append(instructionFR)
        }
        if let instructionIT = item.strInstructionsIT {
            self.instructionLanguagesList.append("🇮🇹Italian")
            self.instructionList.append(instructionIT)
        }
    }
    
    @objc func changeInstructionLanguage(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            instructionTextView.text = instructionList[0]
        case 1:
            instructionTextView.text = instructionList[1]
        case 2:
            instructionTextView.text = instructionList[2]
        case 3:
            instructionTextView.text = instructionList[3]
        case 4:
            instructionTextView.text = instructionList[4]
        default:
            print("Fatal error")
        }
    }
    
    @objc func scrollIngredients() {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
    
    @objc func addToFavourites() {
        UIView.animate(withDuration: 1, delay: 0.1, options: .transitionFlipFromBottom, animations: {
            if self.cocktailSaved == true {
                self.addToFavouritesButton = UIImage(systemName: "heart")!.withTintColor(.white, renderingMode: .alwaysOriginal)
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: self.addToFavouritesButton, style: .plain, target: self, action: #selector(self.addToFavourites))
                self.cocktailSaved = false
                self.favouriteCocktails.removeLast()
                self.saveFavouriteCocktails()
            } else {
                self.addToFavouritesButton = UIImage(systemName: "heart.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: self.addToFavouritesButton, style: .plain, target: self, action: #selector(self.addToFavourites))
                self.cocktailSaved = true
                self.favouriteCocktails.append(self.item!)
                self.saveFavouriteCocktails()
            }
        }, completion: nil)
    }
    func saveFavouriteCocktails() {
        let encoder = JSONEncoder()
        if let savedData = try? encoder.encode(favouriteCocktails) {
            UserDefaults.standard.set(savedData, forKey: "favouriteCocktails")
            print("Cocktail saved")
        } else {
            print("Failed saving people")
        }
    }
    
    func loadFavouriteCocktails() {
        print("We are loading")
        DispatchQueue.global(qos: .background).async { [self] in
            if let cocktailsData = UserDefaults.standard.object(forKey: "favouriteCocktails") as? Data {
                let decoder = JSONDecoder()
                
                do {
                    self.favouriteCocktails = try decoder.decode([Cocktail].self, from: cocktailsData)
                    print("Cocktails decoded")
                    for el in self.favouriteCocktails {
                        if el.strDrink == self.item?.strDrink {
                            print("similar cocktail found")
                            self.addToFavouritesButton = UIImage(systemName: "heart.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
                            DispatchQueue.main.async {
                                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: self.addToFavouritesButton, style: .plain, target: self, action: #selector(self.addToFavourites))
                            }
                            self.cocktailSaved = true
                            break
                        }
                    }
                } catch {
                    print("Error decoding cocktails")
                }
            } else {
                print("No cocktails")
            }
        }
    }
}

extension DetailCocktailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: Collection view methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredientsList.ingredientsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IngredientCell
        cell.data = ingredientsList.ingredientsList[indexPath.row]
        return cell
    }
}
