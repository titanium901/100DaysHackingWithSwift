//
//  DetailTableViewController.swift
//  MilestoneProject13-15
//
//  Created by Yury Popov on 05/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    @IBOutlet var areaLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var flagImage: UIImageView!
    
    var country: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = "\(country.population)"
        areaLabel.text = "\(country.area)"
        currencyLabel.text = country.currency
        flagImage.image = UIImage(named: country.name)
        flagImage.layer.borderWidth = 1
        flagImage.layer.borderColor = UIColor.lightGray.cgColor
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imageAnimate()
        nameAnimate()
        infoAnimate()
    }
    
    func imageAnimate() {
        UIView.animate(withDuration: 0, animations: {
            self.flagImage.alpha = 0
            self.flagImage.transform = CGAffineTransform(translationX: 0, y: 30)
            
        }) { (_) in
            UIView.animate(withDuration: 4, animations: {
                self.flagImage.alpha = 1
                self.flagImage.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
    
    func nameAnimate() {
        UIView.animate(withDuration: 0, animations: {
            self.nameLabel.alpha = 0
        }) { (_) in
            UIView.animate(withDuration: 1, animations: {
                self.nameLabel.alpha = 1
            })
        }
    }
    
    func infoAnimate() {
        UIView.animate(withDuration: 0, animations: {
            self.capitalLabel.alpha = 0
            self.populationLabel.alpha = 0
            self.areaLabel.alpha = 0
            self.currencyLabel.alpha = 0
        }) { (_) in
            UIView.animate(withDuration: 3, animations: {
                self.capitalLabel.alpha = 1
                self.populationLabel.alpha = 1
                self.areaLabel.alpha = 1
                self.currencyLabel.alpha = 1
            })
        }
    }

}
