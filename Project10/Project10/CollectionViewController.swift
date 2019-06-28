//
//  CollectionViewController.swift
//  Project10
//
//  Created by Yury Popov on 27/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit



class CollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(cameraOrLibary))
      
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell")
        }
        let person = people[indexPath.item]
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let alert = UIAlertController(title: "What you wanna do?", message: nil, preferredStyle: .alert)
        let deleteButton = UIAlertAction(title: "Delete", style: .default) { [weak self] _ in
            self?.deletePerson(person: person, index: indexPath)
        }
        let renameButton = UIAlertAction(title: "Rename", style: .cancel) { [weak self] _ in
            self?.renameLabel(person: person)
            
        }
        alert.addAction(deleteButton)
        alert.addAction(renameButton)
        present(alert, animated: true)
        
//        renameLabel(person: person)
        
    }
    @objc func deletePerson(person: Person, index: IndexPath) {
        people.remove(at: index.item)
        collectionView.reloadData()
    }
    
    @objc func renameLabel(person: Person) {
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        
        //        ac.addAction(UIAlertAction(title: "Cancel", style: .default) { [weak self, weak ac] _ in
        //            guard let newName = ac?.textFields?[0].text else { return }
        //            person.name = newName
        //
        //            self?.collectionView.reloadData()
        //        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        let okButton = UIAlertAction(title: "Ok", style: .cancel) {[weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName
            
            self?.collectionView.reloadData()
        }
        ac.addAction(okButton)
        
        
        present(ac, animated: true)
    }
    
    
//    @objc func addNewPerson() {
//        let picker = UIImagePickerController()
//        let isCamer = UIImagePickerController.isSourceTypeAvailable(.camera)
//        if isCamer {
//            print("Yes")
//            picker.sourceType = .camera
//            picker.allowsEditing = true
//            picker.delegate = self
//            present(picker, animated: true)
//        } else {
//            print("NO")
//            picker.sourceType = .photoLibrary
//            picker.allowsEditing = true
//            picker.delegate = self
//            present(picker, animated: true)
//        }
//
//
//
//    }
    
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
    
    @objc func cameraOrLibary() {
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
        }
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}
