//
//  CollectionViewController.swift
//  Project10
//
//  Created by Yury Popov on 27/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit
import LocalAuthentication



class CollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var people = [Person]()
    var savePeoples = [Person]()
    var addButton: UIBarButtonItem!
    var unlockButton: UIBarButtonItem!
    var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton = UIBarButtonItem(title: "Save and Quit", style: .plain, target: self, action: #selector(savePeoople))
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(cameraOrLibary))
        navigationItem.leftBarButtonItem = nil
        unlockButton = UIBarButtonItem(title: "Unlock", style: .plain, target: self, action: #selector(unlockPersons))
        navigationItem.rightBarButtonItem = unlockButton
      
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if navigationItem.leftBarButtonItem == nil {
            return people.count
        } else {
            return savePeoples.count
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell")
        }
        let person = savePeoples[indexPath.item]
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
        let person = savePeoples[indexPath.item]
        
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
    
    @objc func savePeoople() {
        print("Save")
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = unlockButton
        collectionView.reloadData()
        
    }
    
    @objc func unlockPersons() {
        authBiometric()
    }
    
    @objc func deletePerson(person: Person, index: IndexPath) {
        savePeoples.remove(at: index.item)
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
        let ac = UIAlertController(title: "Take Photo", message: "Where do you want to take a photo?", preferredStyle: .actionSheet)
        
        if !isCamer {
            let camera = UIAlertAction(title: "Camera not available", style: .default)
            camera.isEnabled = false
            ac.addAction(camera)
        } else {
            let cameraAv = UIAlertAction(title: "Camera", style: .default) { _ in
                let picker = UIImagePickerController()
                self.pickerChouse(picker: picker, isCamera: true)
            }
            ac.addAction(cameraAv)
        }
        
        let libary = UIAlertAction(title: "Photo Libary", style: .default) { _ in
            let picker = UIImagePickerController()
            self.pickerChouse(picker: picker, isCamera: false)
        }
        ac.addAction(libary)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancel)
        present(ac, animated: true)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let person = Person(name: "Unknown", image: imageName)
        savePeoples.append(person)
        collectionView.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func authBiometric() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.navigationItem.leftBarButtonItem = self?.addButton
                        self?.navigationItem.rightBarButtonItem = self?.saveButton
                        self?.collectionView.reloadData()
                    } else {
                        // error
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            // no biometry
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }


}
