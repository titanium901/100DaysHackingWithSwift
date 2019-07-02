//
//  DetailViewController.swift
//  MilestoneProject10-12
//
//  Created by Yury Popov on 02/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var image: UIImageView!
    
    var selectedImage: FotoCard?
    var path: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        image.image = UIImage(contentsOfFile: path.path)
        name.text = selectedImage?.name
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
