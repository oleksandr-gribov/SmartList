//
//  DetailViewController.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 5/22/19.
//  Copyright © 2019 Oleksandr Gribov. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
   
    var item: Item?
    var imageCache: ImageCache!
    var baseImage: UIImage?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self as! UITextFieldDelegate
   
        self.navigationItem.title = "Details"
        if let item = item {
           // self.navigationItem.title = item.name
            
            nameTextField.text = item.name
            imageView.image = imageCache.getImage(forKey: item.uID)
        } else {
            // Testing code
            //self.nameTextField.text = EdamamAPI.upcCode
            EdamamAPI.fetchProductData { (item) in
                if let item = item {
                    print("Successfuly decoded \(item.name) from JSON")
                    if let url = item.imageURL {
                        self.fetchPhoto(with: item)
                    } else {
                        DispatchQueue.main.async {
                            self.nameTextField.text = item.name
                            self.baseImage = UIImage(imageLiteralResourceName: "Image")
                        }
                    }
                } else {
                    print ("Couldnt fetch product data")
                }
            }
        }
        
       updateSaveButton()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
       
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
       if let photo = imageView.image ,
        let name = nameTextField.text {
        item = Item(name: name)
        guard let uid = item?.uID else {
            return
        }
        imageCache.setImage(photo, forKey: uid)
        
    }
    }
    
    private func updateSaveButton() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    // MARK: - Actions
   
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard if the user is currently typing
        nameTextField.resignFirstResponder()
        
        // View controller that lets the user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        present(imagePickerController,animated: true, completion: nil)
    }
    
    // MARK: - Image Pikcer methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss the picker if the user has cancelled
        dismiss(animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original
         let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
       // imageCache.setImage(selectedImage, forKey: item?.uID)
        
        // Set photoImageView to dispay the selected image.
        imageView.image = selectedImage
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Network code
     func fetchPhoto (with item: Item ) {
        if let url = item.imageURL {
            print("Image url is: \(url)")
            let task = URLSession.shared.dataTask(with: url, completionHandler: {
                (data, error, response) in
                if let data = data,
                    let image = UIImage(data: data) {
                    print(String(data: data, encoding: .utf8))
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        self.nameTextField.text = item.name
                        self.saveButton.isEnabled = true
                        self.baseImage = image
                    }
                }
            })
            task.resume()
        }
    }
}
    

