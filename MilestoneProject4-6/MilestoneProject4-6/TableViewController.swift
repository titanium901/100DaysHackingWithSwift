//
//  TableViewController.swift
//  MilestoneProject4-6
//
//  Created by Yury Popov on 20/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var shopItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearTable))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareItems))
        
        navigationItem.rightBarButtonItems = [trashButton, addButton]
        shopItems += ["Test"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shopItems[indexPath.row]
        return cell
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "What do you want to buy today? 🧐", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let itemText = ac.textFields?[0].text else { return }
            self.add(itemText)
        }
        
        ac.addAction(addAction)
        present(ac, animated: true)
    }
    
    func add(_ item: String){
        if !item.isEmpty {
            //сначало добавляем item в array потом только в tableview иначе crash
            shopItems.insert(item, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func clearTable() {
        shopItems.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareItems() {
        let text = "List to buy:"
        let list = shopItems.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [text, list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![0]
        present(vc, animated: true)
    }
}
