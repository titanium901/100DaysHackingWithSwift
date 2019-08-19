//
//  ViewController.swift
//  MilestoneProject25-27
//
//  Created by Yury Popov on 19/08/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var auxImageView: UIImageView!
    @IBOutlet weak var addTextButton: UIButton!
    
    
    let isCamer = UIImagePickerController.isSourceTypeAvailable(.camera)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextButton.isEnabled = false
    }


    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        //share meme
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No Image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    @IBAction func takePhotoButton(_ sender: Any) {
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
    
    @IBAction func addTextButton(_ sender: UIButton) {
        let ac = UIAlertController(title: "Add Text", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            let headerText = ac.textFields![0].text ?? ""
            let footerText = ac.textFields![1].text ?? ""
            self.setTextToImage(header: headerText, footer: footerText)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { headerText in
            headerText.placeholder = "Add HeaderText"
        }
        ac.addTextField { footerText in
            footerText.placeholder = "Add FooterText"
        }
        
        
        present(ac, animated: true)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        addTextButton.isEnabled = true
        
        auxImageView.image = imageView.image
        
        let renderer = UIGraphicsImageRenderer(size: imageView.frame.size)
        
        let rendImage = renderer.image { ctx in
            
            let storImage = image
            storImage.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            
        }
        imageView.image = rendImage
        imageView.alpha = 0
        
        auxImageView.alpha = 1
       
        picker.dismiss(animated: true) {
            
            self.delay(seconds: 0.10) {
                UIView.animate(withDuration: 2) {
                    self.imageView.alpha = 1
                    self.auxImageView.alpha = 0
                }
            }
        }
    }
    
    func delay(seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
    
    func setTextToImage(header: String, footer: String) {
        let renderer = UIGraphicsImageRenderer(size: imageView.frame.size)
        
        
        let image = renderer.image { ctx in
            
            let stormImage = imageView.image
            stormImage?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font : UIFont(name: "Marker Felt", size: 40)!,
                .foregroundColor : UIColor.white,
                .strokeWidth : -3.0,
                .strokeColor: UIColor.black,
                .paragraphStyle: paragraphStyle
            ]
            
            let headAttributedString = NSAttributedString(string: header.uppercased(), attributes: attrs)
            
            headAttributedString.draw(with: CGRect(x: 0, y: 20, width: imageView.frame.size.width, height: 40), options: .usesLineFragmentOrigin, context: nil)
            
            let footerAttributedString = NSAttributedString(string: footer.uppercased(), attributes: attrs)
            footerAttributedString.draw(with: CGRect(x: 0, y: imageView.frame.size.height - 60, width: imageView.frame.size.width, height: 40), options: .usesLineFragmentOrigin, context: nil)
        }
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = image
        
    }
}

