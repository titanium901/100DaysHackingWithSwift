//
//  CreareNoteViewController.swift
//  MilestoneProject19-21
//
//  Created by Yury Popov on 18/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class CreareNoteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var textView: UITextView!
    var note = Note(name: "", text: "")
    var isNew = true
    let date = Date()
    let formatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = note.text
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        textView.delegate = self
        textView.becomeFirstResponder()
        
        let notificationCentre = NotificationCenter.default
        notificationCentre.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCentre.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        note.name = formatter.string(from: date)
        note.text = textView.text
        
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndValue = keyboardValue.cgRectValue
        let keyboardViewEndValue = view.convert(keyboardScreenEndValue, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = .zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndValue.height - view.safeAreaInsets.bottom, right: 0)
        }
        textView.scrollIndicatorInsets = textView.contentInset
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }
    
    
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        let shareText = textView.text ?? "No text Found"
        
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        present(vc, animated: true)
        
    }
}
