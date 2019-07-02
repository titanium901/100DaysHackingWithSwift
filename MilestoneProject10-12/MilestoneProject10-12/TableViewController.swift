//
//  TableViewController.swift
//  MilestoneProject10-12
//
//  Created by Yury Popov on 02/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var fotoCards = [FotoCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewFoto))
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fotoCards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Foto", for: indexPath) as? TableViewCell else {
            fatalError("Unable to dequeue Cell")
        }
        let fotoCard = fotoCards[indexPath.row]
        cell.name.text = fotoCard.name
        
        
        
        let path = getDocumentsDirectory().appendingPathComponent(fotoCard.image)
        cell.imageName.image = UIImage(contentsOfFile: path.path)
        
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)

        let fotoCard = fotoCards[indexPath.row]
        
        showRenameAlert(fotoCard: fotoCard)
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(#function)
        if  let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let index = indexPath.row
            vc.selectedImage = fotoCards[index]
            vc.path = getDocumentsDirectory().appendingPathComponent(fotoCards[index].image)
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Foto"
        }
    }
    
    
    func pickerChouse(picker: UIImagePickerController, isCamera: Bool ) {
        if isCamera {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @objc func addNewFoto() {
        let isCamer = UIImagePickerController.isSourceTypeAvailable(.camera)
        if isCamer {
            let ac = UIAlertController(title: "What you wanna use?", message: nil, preferredStyle: .actionSheet)
            let cameraButton = UIAlertAction(title: "Camera", style: .default) { _ in
                let picker = UIImagePickerController()
                self.pickerChouse(picker: picker, isCamera: isCamer)
                
            }
            let photoButton = UIAlertAction(title: "Libary", style: .default) { _ in
                let picker = UIImagePickerController()
                self.pickerChouse(picker: picker, isCamera: !isCamer)
                
            }
            ac.addAction(cameraButton)
            ac.addAction(photoButton)
            present(ac, animated: true)
        } else {
            let picker = UIImagePickerController()
            pickerChouse(picker: picker, isCamera: isCamer)
            
        }
        
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let fotoCard = FotoCard(name: "Unknow", image: imageName)
        
        fotoCards.append(fotoCard)
        tableView.reloadData()

        dismiss(animated: true)
    }

    func showRenameAlert(fotoCard: FotoCard) {
        
        let ac = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?[0].text = fotoCard.name
        let ok = UIAlertAction(title: "Ok", style: .default) {[weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            fotoCard.name = newName
            self?.tableView.reloadData()
            
        }
        
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true)
        
    }
 
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
