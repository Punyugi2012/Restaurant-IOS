//
//  DetailViewController.swift
//  FoodPin
//
//  Created by punyawee  on 24/4/61.
//  Copyright © พ.ศ. 2561 AppCoda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var ResImage: UIImageView!
    @IBOutlet weak var ResName: UILabel!
    @IBOutlet weak var ResLocation: UILabel!
    @IBOutlet weak var ResType: UILabel!
    
    var name: String?
    var type: String?
    var location: String?
    var image: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setValue() {
        guard let nName = name else {
            return
        }
        guard let nType = type else {
            return
        }
        guard let nLocation = location else {
            return
        }
        guard let nImage = image else {
            return
        }
        self.ResImage.image = UIImage(named: nImage)
        self.ResName.text = nName
        self.ResType.text = nType
        self.ResLocation.text = nLocation
    }

}
