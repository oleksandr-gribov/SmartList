//
//  DetailViewController.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 5/22/19.
//  Copyright © 2019 Oleksandr Gribov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITextFieldDelegate {
    
    var item: Item?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self as! UITextFieldDelegate
      //  nameTextField.delegate = self as! UITextFieldDelegate
        
        if let item = item {
            self.navigationItem.title = item.name
            nameTextField.text = item.name
        }
       updateSaveButton()
        
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButton()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Sabe button while editing
        saveButton.isEnabled = false
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as! MainViewController
        
        let name = nameTextField.text ?? ""
        item = Item(name)
    }
    
    private func updateSaveButton() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
