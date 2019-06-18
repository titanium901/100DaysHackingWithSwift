//
//  TableViewController.swift
//  MilestoneProject1-3
//
//  Created by Yury Popov on 18/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var flags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("3x.png") {
                flags.append(item)
            }
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row].uppercased().replacingOccurrences(of: "@3X.PNG", with: "")
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let index = indexPath.row
            vc.imageName = flags[index]
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Flag of \(flags[index].uppercased().replacingOccurrences(of: "@3X.PNG", with: ""))"
        }
    }
   
}
