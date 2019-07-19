//
//  FolderTableViewController.swift
//  MilestoneProject19-21
//
//  Created by Yury Popov on 18/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class FolderTableViewController: UITableViewController {
    @IBOutlet var buttonForNotesCount: UIBarButtonItem!
    
    var notes: [Note]?
    var titleVC: String?
    var notts = [Note]()
    
    
    var count = 0.0 {
        didSet {
            buttonForNotesCount.title = "\(notes?.count ?? 0) Notes"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999126792, green: 1, blue: 0.9998814464, alpha: 1)
        navigationController?.toolbar.barTintColor = #colorLiteral(red: 0.9999126792, green: 1, blue: 0.9998814464, alpha: 1)
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        title = titleVC
        editButtonItem.tintColor = #colorLiteral(red: 0.971363008, green: 0.577881217, blue: 0.006590880454, alpha: 1)
        count += 0.0
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Folder", for: indexPath)

        let note = notes?[indexPath.row]
        cell.textLabel?.text = "\(note!.name) - \(note?.text ?? "Text From Note")"
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            count -= 0.1
        }
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Note" {
            let noteVC = segue.destination as! CreareNoteViewController
            noteVC.title = ""
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.971363008, green: 0.577881217, blue: 0.006590880454, alpha: 1)
            count += 0.1
        }
        if segue.identifier == "SeeNote" {
            let noteVC = segue.destination as! CreareNoteViewController
            let path = tableView.indexPathForSelectedRow
            noteVC.note = notes![(path?.row)!]
            noteVC.title = ""
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.971363008, green: 0.577881217, blue: 0.006590880454, alpha: 1)
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSeque" else { return }
        guard let noteVC = segue.source as? CreareNoteViewController else { return }
        let note = noteVC.note
        print(note.name)
        
        if let path = tableView.indexPathForSelectedRow {
            notes?[path.row] = note
            tableView.deselectRow(at: path, animated: false)
        } else {
            notes?.append(note)
           
        }
        tableView.reloadData()
        count += 0.0
    }
    
}
