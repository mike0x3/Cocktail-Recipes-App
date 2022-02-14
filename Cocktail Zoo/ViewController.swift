//
//  ViewController.swift
//  Cocktail Zoo
//
//  Created by Mikhaylo Chornenkiy on 26.12.21.
//

import UIKit
import SkeletonView

class ViewController: UIViewController {

    var data: [Cocktail] = []
    var analcoholicData: [Cocktail] = []
    var favouriteCocktails: [Cocktail] = []
    
    var collectionView: UICollectionView! = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var analcoholicCollectionView: UICollectionView! = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    let topCocktailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Most Popular Cocktails"
        label.font = UIFont(name: "Georgia-Bold", size: 24)!
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var favouriteCocktailsButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "heart.fill")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal), for: .normal)
        b.addTarget(self, action: #selector(openFavouriteCocktails), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let topNonAlcoholicCocktailsLabel: UILabel = {
        let l = UILabel()
        l.text = "Non Alcoholic Classics"
        l.font = UIFont(name: "Georgia-Bold", size: 24)!
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 32/255, green: 33/255, blue: 36/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        collectionView = {
            let layout: UICollectionViewFlowLayout = {
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.minimumLineSpacing = 20
                layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
                layout.itemSize = CGSize(width: 170, height: 250)
                layout.scrollDirection = .horizontal
                return layout
            }()
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(CocktailCell.self, forCellWithReuseIdentifier: "cell")
            collectionView.backgroundColor = UIColor(red: 32/255, green: 33/255, blue: 36/255, alpha: 1)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isSkeletonable = true
            //collectionView.isUserInteractionDisabledWhenSkeletonIsActive = false
            return collectionView
        }()
        
        analcoholicCollectionView = {
            let layout: UICollectionViewFlowLayout = {
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.minimumLineSpacing = 20
                layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
                layout.itemSize = CGSize(width: 170, height: 250)
                layout.scrollDirection = .horizontal
                return layout
            }()
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(CocktailCell.self, forCellWithReuseIdentifier: "cell")
            collectionView.backgroundColor = UIColor(red: 32/255, green: 33/255, blue: 36/255, alpha: 1)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isSkeletonable = true
            //collectionView.isUserInteractionDisabledWhenSkeletonIsActive = false
            return collectionView
        }()
        
        view.addSubview(topCocktailsLabel)
        view.addSubview(favouriteCocktailsButton)
        view.addSubview(collectionView)
        
        view.addSubview(topNonAlcoholicCocktailsLabel)
        view.addSubview(analcoholicCollectionView)
        
        NSLayoutConstraint.activate([
            topCocktailsLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            topCocktailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            favouriteCocktailsButton.topAnchor.constraint(equalTo: topCocktailsLabel.topAnchor, constant: -2),
            favouriteCocktailsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            favouriteCocktailsButton.heightAnchor.constraint(equalToConstant: 30),
            favouriteCocktailsButton.widthAnchor.constraint(equalToConstant: 30),
            
            
            collectionView.topAnchor.constraint(equalTo: topCocktailsLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            
            topNonAlcoholicCocktailsLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            topNonAlcoholicCocktailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            analcoholicCollectionView.topAnchor.constraint(equalTo: topNonAlcoholicCocktailsLabel.bottomAnchor, constant: 10),
            analcoholicCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            analcoholicCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            analcoholicCollectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        searchDrink(drinkName: "cosmopolitan", type: .Alcoholic)
        searchDrink(drinkName: "mojito", type: .Alcoholic)
        searchDrink(drinkName: "mai tai", type: .Alcoholic)
        searchDrink(drinkName: "mint julep", type: .Alcoholic)
        searchDrink(drinkName: "caipirinha", type: .Alcoholic)
        searchDrink(drinkName: "margarita", type: .Alcoholic)
        searchDrink(drinkName: "pina colada", type: .Alcoholic)
        searchDrink(drinkName: "long island iced tea", type: .Alcoholic)
        
        searchDrink(drinkName: "Bora Bora", type: .AlcoholFree)
        searchDrink(drinkName: "Ipamena", type: .AlcoholFree)
        searchDrink(drinkName: "Masala Chai", type: .AlcoholFree)
        searchDrink(drinkName: "Spanish chocolate", type: .AlcoholFree)
        searchDrink(drinkName: "Tomato Tang", type: .AlcoholFree)
    }
    @objc func openFavouriteCocktails() {
        print("Favourite cocktails")
        if let cocktailsData = UserDefaults.standard.object(forKey: "favouriteCocktails") as? Data {
            let decoder = JSONDecoder()
            
            do {
                self.favouriteCocktails = try decoder.decode([Cocktail].self, from: cocktailsData)
                print("Cocktails decoded")
            } catch {
                print("Error decoding cocktails")
            }
        } else {
            print("No cocktails")
        }
        let favouriteCocktailsPage = FavouriteCocktailsTableViewController(style: .plain)
        favouriteCocktailsPage.dataArray = favouriteCocktails
        navigationController?.pushViewController(favouriteCocktailsPage, animated: true)
    }
}

extension ViewController: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource {
    //MARK: Homa page collection view methods
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return data.count
        } else {
            return analcoholicData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CocktailCell
        if collectionView == self.collectionView {
            cell.data = data[indexPath.row]
        } else {
            cell.data = analcoholicData[indexPath.row]
        }
        cell.isSkeletonable = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var element = data[indexPath.row]
        if collectionView == self.collectionView {
            element = data[indexPath.row]
        } else {
            element = analcoholicData[indexPath.row]
        }
        let detailView = DetailCocktailViewController()
        detailView.item = element
        let ingredientsList = parseIngredients(item: element)
        detailView.ingredientsList = ingredientsList
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), identifier: nil, discoverabilityTitle: nil, state: .off){ (_) in
                var cocktailName = "Mojito"
                if collectionView == self.collectionView  {
                    cocktailName = self.data[indexPath.row].strDrink
                } else {
                    cocktailName = self.analcoholicData[indexPath.row].strDrink
                }
                let text = "Hey check this out! In this application you can see the recipe of the \(cocktailName) and all other cocktails. Download it from here:"
                let url = NSURL(string: "https://apps.apple.com/it/app/cocktail-flow/id486811622")
                
                let controller = UIActivityViewController(activityItems: [text, url!], applicationActivities: nil)
                controller.popoverPresentationController?.sourceView = self.view
                controller.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
                self.present(controller, animated: true, completion: nil)
                
            }
            let menu = UIMenu(title: "Options", image: nil, identifier: nil, options: .displayInline, children: [share])
            return menu
        }
        return context
    }
}

extension ViewController {
    //MARK: API Requests and received data elaboration
    func searchDrink(drinkName: String, type: CocktailType) {
        let drinkNameReady = drinkName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let cosmopolitanUrl = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(drinkNameReady)"
        if let url = URL(string: cosmopolitanUrl) {
            if let data = try? Data(contentsOf: url) {
                self.parse(json: data, type: type)
            }
        }
    }
    
    func parse(json: Data, type: CocktailType) {
        let decoder = JSONDecoder()
        if let jsonCocktails = try? decoder.decode(Cocktails.self, from: json) {
            if type == .Alcoholic {
                data.append(jsonCocktails.drinks[0])
                let indexPath = IndexPath(row: data.count - 1, section: 0)
                self.collectionView.insertItems(at: [indexPath])
            } else if type == .AlcoholFree {
                analcoholicData.append(jsonCocktails.drinks[0])
                let indexPath = IndexPath(row: analcoholicData.count - 1, section: 0)
                self.analcoholicCollectionView.insertItems(at: [indexPath])
            }
        }
    }
}

func parseIngredients(item: Cocktail) -> Ingredients {
    var ingredients = Ingredients(ingredientsList: [])
    if let ingredient1 = item.strIngredient1 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient1!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient1 = Ingredient(name: item.strIngredient1!, imageURL: ingredientImageUrl, measure: item.strMeasure1 ?? "?")
        ingredients.ingredientsList.append(ingredient1)
    }
    if let ingredient2 = item.strIngredient2 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient2!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient2 = Ingredient(name: item.strIngredient2!, imageURL: ingredientImageUrl, measure: item.strMeasure2 ?? "?")
        ingredients.ingredientsList.append(ingredient2)
    }
    if let ingredient3 = item.strIngredient3 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient3!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient3 = Ingredient(name: item.strIngredient3!, imageURL: ingredientImageUrl, measure: item.strMeasure3 ?? "?")
        ingredients.ingredientsList.append(ingredient3)
    }
    if let ingredient4 = item.strIngredient4 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient4!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient4 = Ingredient(name: item.strIngredient4!, imageURL: ingredientImageUrl, measure: item.strMeasure4 ?? "?")
        ingredients.ingredientsList.append(ingredient4)
    }
    if let ingredient5 = item.strIngredient5 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient5!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient5 = Ingredient(name: item.strIngredient5!, imageURL: ingredientImageUrl, measure: item.strMeasure5 ?? "?")
        ingredients.ingredientsList.append(ingredient5)
    }
    if let ingredient6 = item.strIngredient6 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient6!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient6 = Ingredient(name: item.strIngredient6!, imageURL: ingredientImageUrl, measure: item.strMeasure6 ?? "?")
        ingredients.ingredientsList.append(ingredient6)
    }
    if let ingredient7 = item.strIngredient7 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient7!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient7 = Ingredient(name: item.strIngredient7!, imageURL: ingredientImageUrl, measure: item.strMeasure7 ?? "?")
        ingredients.ingredientsList.append(ingredient7)
    }
    if let ingredient8 = item.strIngredient8 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient8!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient8 = Ingredient(name: item.strIngredient8!, imageURL: ingredientImageUrl, measure: item.strMeasure8 ?? "?")
        ingredients.ingredientsList.append(ingredient8)
    }
    if let ingredient9 = item.strIngredient9 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient9!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient9 = Ingredient(name: item.strIngredient9!, imageURL: ingredientImageUrl, measure: item.strMeasure9 ?? "?")
        ingredients.ingredientsList.append(ingredient9)
    }
    if let ingredient10 = item.strIngredient10 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient10!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient10 = Ingredient(name: item.strIngredient10!, imageURL: ingredientImageUrl, measure: item.strMeasure10 ?? "?")
        ingredients.ingredientsList.append(ingredient10)
    }
    if let ingredient11 = item.strIngredient11 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient11!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient11 = Ingredient(name: item.strIngredient11!, imageURL: ingredientImageUrl, measure: item.strMeasure11 ?? "?")
        ingredients.ingredientsList.append(ingredient11)
    }
    if let ingredient12 = item.strIngredient12 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient12!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient12 = Ingredient(name: item.strIngredient12!, imageURL: ingredientImageUrl, measure: item.strMeasure12 ?? "?")
        ingredients.ingredientsList.append(ingredient12)
    }
    if let ingredient13 = item.strIngredient13 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient13!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient13 = Ingredient(name: item.strIngredient13!, imageURL: ingredientImageUrl, measure: item.strMeasure13 ?? "?")
        ingredients.ingredientsList.append(ingredient13)
    }
    if let ingredient14 = item.strIngredient14 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient14!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient14 = Ingredient(name: item.strIngredient14!, imageURL: ingredientImageUrl, measure: item.strMeasure14 ?? "?")
        ingredients.ingredientsList.append(ingredient14)
    }
    if let ingredient15 = item.strIngredient15 {
        let ingredientImageUrl = "https://www.thecocktaildb.com/images/ingredients/\(item.strIngredient15!).png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let ingredient15 = Ingredient(name: item.strIngredient15!, imageURL: ingredientImageUrl, measure: item.strMeasure15 ?? "?")
        ingredients.ingredientsList.append(ingredient15)
    }
    return ingredients
}
