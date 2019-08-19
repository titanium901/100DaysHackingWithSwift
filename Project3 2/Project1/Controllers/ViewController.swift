//
//  ViewController.swift
//  Project1
//
//  Created by Yury Popov on 14/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.imageView?.image = UIImage(named: pictures[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let index = indexPath.row
            vc.selectedPicture = pictures[index]
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Picture \(index + 1) of \(pictures.count)"
        }
    }
    
    @objc func shareTapped() {
        let str = "Hi friend! This is awesome app! Download here https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt="
        
        let vc = UIActivityViewController(activityItems: [str], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}

