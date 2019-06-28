//
//  ViewController.swift
//  Project1
//
//  Created by Yury Popov on 14/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        performSelector(inBackground: #selector(fetchPictures), with: nil)
        print(#function)
    }
    
    @objc func fetchPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        if let items = try? fm.contentsOfDirectory(atPath: path) {
            for item in items {
                if item.hasPrefix("nssl") {
                    pictures.append(item)
                }
            }
            pictures.sort()
            
            
        }
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.imageView.image = UIImage(named: pictures[indexPath.row])
        cell.namePicture.text = pictures[indexPath.row]
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
//        cell.textLabel?.text = pictures[indexPath.row]
//        cell.imageView?.image = UIImage(named: pictures[indexPath.row])
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let index = indexPath.row
            vc.selectedImage = pictures[index]
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Picture \(index + 1) of \(pictures.count)"
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if  let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            let index = indexPath.row
//            vc.selectedImage = pictures[index]
//            navigationController?.pushViewController(vc, animated: true)
//            vc.title = "Picture \(index + 1) of \(pictures.count)"
//        }
//    }
}

