//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 24/8/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    var restaurantIsVisited: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantIsVisited = Array(repeating: false, count: self.restaurantNames.count)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let oldName = self.restaurantNames.remove(at: sourceIndexPath.row)
        let oldImage = self.restaurantImages.remove(at: sourceIndexPath.row)
        let oldLoca = self.restaurantLocations.remove(at: sourceIndexPath.row)
        let oldType = self.restaurantTypes.remove(at: sourceIndexPath.row)
        let oldVisited = self.restaurantIsVisited.remove(at: sourceIndexPath.row)
        self.restaurantNames.insert(oldName, at: destinationIndexPath.row)
        self.restaurantImages.insert(oldImage, at: destinationIndexPath.row)
        self.restaurantLocations.insert(oldLoca, at: destinationIndexPath.row)
        self.restaurantTypes.insert(oldType, at: destinationIndexPath.row)
        self.restaurantIsVisited.insert(oldVisited, at: destinationIndexPath.row)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantImages.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        if self.restaurantIsVisited[indexPath.row] == false {
            cell.selectImage.image = nil
        }
        else {
            cell.selectImage.image = UIImage(named: "hearttick")
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)! as! RestaurantTableViewCell
        let optionMenu = UIAlertController(title: "Menu", message: "What do you want to do?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let callActionHandler = { (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, th call feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        let callAction = UIAlertAction(title: "Call " + "123-00-\(indexPath.row)", style: .default, handler: callActionHandler)

        optionMenu.addAction(callAction)
        optionMenu.addAction(cancelAction)
        if self.restaurantIsVisited[indexPath.row] == true {
            let uncheckAction = UIAlertAction(title: "UnCheck in", style: .destructive) { (alert: UIAlertAction) in
                cell.selectImage.image = nil
                self.restaurantIsVisited[indexPath.row] = false
            }
            optionMenu.addAction(uncheckAction)
        }
        else {
            let checkInAction = UIAlertAction(title: "Check in", style: .default) { (alert: UIAlertAction) in
                cell.selectImage.image = UIImage(named: "hearttick")
                self.restaurantIsVisited[indexPath.row] = true
            }
            optionMenu.addAction(checkInAction)
        }
        self.present(optionMenu, animated: true, completion: nil)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

}
