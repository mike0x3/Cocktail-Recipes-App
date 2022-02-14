//
//  FavouriteCocktailsTableViewController.swift
//  Cocktail Zoo
//
//  Created by Mikhaylo Chornenkiy on 07.01.22.
//

import UIKit

class FavouriteCocktailsTableViewController: UITableViewController {
    
    var dataArray: [Cocktail] = []
    
    let cellSpacingHeight: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 32/255, green: 33/255, blue: 36/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 32/255, green: 33/255, blue: 36/255, alpha: 1)
        
        title = "Your Favourite Drinks"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(showEditing))
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        tableView.register(CocktailTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 130
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelectionDuringEditing = true
        tableView.backgroundColor = UIColor(red: 32/255, green: 33/255, blue: 36/255, alpha: 1)
    }
    
    @objc func showEditing() {
        if self.tableView.isEditing == true {
            self.tableView.isEditing = false
            navigationItem.rightBarButtonItem?.title = "Edit"
        } else {
            self.tableView.isEditing = true
            navigationItem.rightBarButtonItem?.title = "Done"
        }
    }
    
    func saveFavouriteCocktails() {
        let encoder = JSONEncoder()
        if let savedData = try? encoder.encode(dataArray) {
            UserDefaults.standard.set(savedData, forKey: "favouriteCocktails")
            print("Cocktail saved")
        } else {
            print("Failed saving people")
        }
    }
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CocktailTableViewCell
        cell.data = dataArray[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var element = dataArray[indexPath.row]
        
        let detailView = DetailCocktailViewController()
        detailView.item = element
        let ingredientsList = parseIngredients(item: element)
        detailView.ingredientsList = ingredientsList
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        saveFavouriteCocktails()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red: 32/255, green: 33/255, blue: 36/255, alpha: 1)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
