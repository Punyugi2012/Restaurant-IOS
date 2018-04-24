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
        navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

 
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let oldName = self.restaurantNames.remove(at: sourceIndexPath.row)
//        let oldImage = self.restaurantImages.remove(at: sourceIndexPath.row)
//        let oldLoca = self.restaurantLocations.remove(at: sourceIndexPath.row)
//        let oldType = self.restaurantTypes.remove(at: sourceIndexPath.row)
//        let oldVisited = self.restaurantIsVisited.remove(at: sourceIndexPath.row)
//        self.restaurantNames.insert(oldName, at: destinationIndexPath.row)
//        self.restaurantImages.insert(oldImage, at: destinationIndexPath.row)
//        self.restaurantLocations.insert(oldLoca, at: destinationIndexPath.row)
//        self.restaurantTypes.insert(oldType, at: destinationIndexPath.row)
//        self.restaurantIsVisited.insert(oldVisited, at: destinationIndexPath.row)
//    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.restaurantNames.remove(at: indexPath.row)
//            self.restaurantImages.remove(at: indexPath.row)
//            self.restaurantLocations.remove(at: indexPath.row)
//            self.restaurantTypes.remove(at: indexPath.row)
//            self.restaurantIsVisited.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .none)
//        }
//    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = tableView.cellForRow(at: indexPath)! as! RestaurantTableViewCell
        let action: UIContextualAction
        if self.restaurantIsVisited[indexPath.row] == true {
            action = UIContextualAction(style: .normal, title: "Undo") { (action, sourceView, completeHandler) in
                cell.selectImage.image = nil
                self.restaurantIsVisited[indexPath.row] = false
                completeHandler(true)
            }
            action.image = UIImage(named: "undo")
        }
        else {
            action = UIContextualAction(style: .normal, title: "Checkin") { (action, sourceView, completeHandler) in
                cell.selectImage.image = UIImage(named: "hearttick")
                self.restaurantIsVisited[indexPath.row] = true
                completeHandler(true)
            }
            action.image = UIImage(named: "tick")
        }
        action.backgroundColor = UIColor(red: 109.0/255.0, green: 192.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        return UISwipeActionsConfiguration(actions: [action])
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //delete
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completeHandler) in
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantImages.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            completeHandler(true)
        }
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        
        //share
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completeHandler) in
            let defaultText = "Just checking in at" + self.restaurantNames[indexPath.row]
            let activityController: UIActivityViewController
            if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            }
            else {
                activityController = UIActivityViewController(activityItems: [
                    defaultText], applicationActivities: nil)
            }
            self.present(activityController, animated: true, completion: nil)
            completeHandler(true)
        }
        shareAction.image = UIImage(named: "share")
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        
        return UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
    
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
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)! as! RestaurantTableViewCell
//        let optionMenu = UIAlertController(title: "Menu", message: "What do you want to do?", preferredStyle: .actionSheet)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        let callActionHandler = { (action: UIAlertAction!) -> Void in
//            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, th call feature is not available yet. Please retry later.", preferredStyle: .alert)
//            alertMessage.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
//            self.present(alertMessage, animated: true, completion: nil)
//        }
//        let callAction = UIAlertAction(title: "Call " + "123-00-\(indexPath.row)", style: .default, handler: callActionHandler)
//
//        optionMenu.addAction(callAction)
//        optionMenu.addAction(cancelAction)
//        if self.restaurantIsVisited[indexPath.row] == true {
//            let uncheckAction = UIAlertAction(title: "UnCheck in", style: .destructive) { (alert: UIAlertAction) in
//                cell.selectImage.image = nil
//                self.restaurantIsVisited[indexPath.row] = false
//            }
//            optionMenu.addAction(uncheckAction)
//        }
//        else {
//            let checkInAction = UIAlertAction(title: "Check in", style: .default) { (alert: UIAlertAction) in
//                cell.selectImage.image = UIImage(named: "hearttick")
//                self.restaurantIsVisited[indexPath.row] = true
//            }
//            optionMenu.addAction(checkInAction)
//        }
//        self.present(optionMenu, animated: true, completion: nil)
//        self.tableView.deselectRow(at: indexPath, animated: true)
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let index = self.tableView.indexPathForSelectedRow?.row {
                if let destination = segue.destination as? DetailViewController {
                    destination.image = self.restaurantImages[index]
                    destination.name = self.restaurantNames[index]
                    destination.location = self.restaurantLocations[index]
                    destination.type = self.restaurantTypes[index]
                    destination.title = self.restaurantNames[index]
                }
            }
        }
    }
}
