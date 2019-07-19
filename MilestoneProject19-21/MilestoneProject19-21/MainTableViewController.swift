//
//  MainTableViewController.swift
//  MilestoneProject19-21
//
//  Created by Yury Popov on 18/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var folders = [Folder]()
    var folder: Folder!
    var index = 0
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        folders = createCustomFolders()
        
        if (defaults.object(forKey: "saveFolders") != nil) {
            folders = loadData()
        } else {
            folders = createCustomFolders()
        }
        

        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999126792, green: 1, blue: 0.9998814464, alpha: 1)
        navigationController?.toolbar.barTintColor = #colorLiteral(red: 0.9999126792, green: 1, blue: 0.9998814464, alpha: 1)
        navigationController?.toolbar.tintColor = #colorLiteral(red: 0.971363008, green: 0.577881217, blue: 0.006590880454, alpha: 1)
        

        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        editButtonItem.tintColor = #colorLiteral(red: 0.971363008, green: 0.577881217, blue: 0.006590880454, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(folders)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return folders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Folders", for: indexPath)
        
        let folder = folders[indexPath.row]
        cell.textLabel?.text = folder.name
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            folders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            save(folders)
        }
    }
    //передаем данные
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNotes" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let folderVC = segue.destination as! FolderTableViewController
                index = indexPath.row
                folderVC.notes = folders[index].notes
                for note in folderVC.notes! {
                    print("1")
                    print(note.name)
                }
                folderVC.titleVC = folders[index].name
                //поменять цвет и тайтл кнопки назад
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.971363008, green: 0.577881217, blue: 0.006590880454, alpha: 1)
                
            }
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard segue.identifier == "save" else { return }
        guard let folderVC = segue.source as? FolderTableViewController else { return }
        print("123")
        folders[index].notes = folderVC.notes!
        save(folders)
        
       
        
    }
    
    

    @IBAction func addNewFolder(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "New Folder", message: "Where would you like to add this folder?", preferredStyle: .actionSheet)
        let iCloud = UIAlertAction(title: "iCloud", style: .default) { (_) in
            let ac = UIAlertController(title: "Don`t work", message: "Please contact apple@support.com", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default)
            ac.addAction(ok)
            ac.view.tintColor = #colorLiteral(red: 0.971363008, green: 0.577881217, blue: 0.006590880454, alpha: 1)
            self.present(ac, animated: true)
        }
        ac.addAction(iCloud)
        let myPhone = UIAlertAction(title: "On My Iphone", style: .default) { (_) in
            let ac = UIAlertController(title: "New Folder", message: "Enter a name for this folder.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            let save = UIAlertAction(title: "Save", style: .default) { _ in
                //do save
                guard let nameOfFolder = ac.textFields?[0].text else { return }
                if nameOfFolder.count > 0 {
                    self.addNewFolderHelp(name: nameOfFolder)
                } else {
                    print("No folder")
                    return
                }
                
                            }
            //настраиваем наш textField
            ac.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "Name"
            })
            
            
            
            
            ac.addAction(cancel)
            ac.addAction(save)
            ac.view.tintColor = #colorLiteral(red: 0.971363008, green: 0.577881217, blue: 0.006590880454, alpha: 1)
            self.present(ac, animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.view.tintColor = #colorLiteral(red: 0.971363008, green: 0.577881217, blue: 0.006590880454, alpha: 1)
        ac.addAction(cancel)
        ac.addAction(myPhone)
        present(ac, animated: true)
    }
    
    
    func addNewFolderHelp(name: String) {
        let folder = Folder(name: name, notes: [Note(name: "", text: "")])
        folders.append(folder)
        save(folders)
        //добавляем ячейку не перегружая всю таблицу
        tableView.insertRows(at: [IndexPath(row: folders.count - 1, section: 0)], with: .left)
    }
    
    
    func createCustomFolders() -> [Folder] {
        var foldersArray = [Folder]()
        let folderOne = Folder(name: "iCloud", notes: [Note(name: "One", text: ""), Note(name: "Two", text: ""), Note(name: "Three", text: "")])
        let folderTwo = Folder(name: "Best", notes: [Note(name: "One", text: ""), Note(name: "Two", text: ""), Note(name: "Three", text: "")])
        let folderThree = Folder(name: "Secret", notes: [Note(name: "One", text: ""), Note(name: "Two", text: ""), Note(name: "Three", text: "")])
        foldersArray.append(folderOne)
        foldersArray.append(folderTwo)
        foldersArray.append(folderThree)
        return foldersArray
        
    }
    
    func save(_ folders: [Folder]) {
        let defaults = UserDefaults.standard
        let data = folders.map { try? JSONEncoder().encode($0)}
        defaults.set(data, forKey: "saveFolders")
        print("save")
    }
    
    func loadData() -> [Folder] {
        let defaults = UserDefaults.standard
        guard let encodeData = defaults.array(forKey: "saveFolders") as? [Data] else {
            return []
        }
        
        return encodeData.map { try! JSONDecoder().decode(Folder.self, from: $0) }
    }

}
