//
//  MainViewController.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 3/22/19.
//  Copyright © 2019 Oleksandr Gribov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var allItems =  [Item]()
    var doneItems = [Item]()
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    @IBOutlet var itemField: UITextField!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        itemField.delegate = self
        self.navigationItem.title = "SmartList"
//        
//        tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.doubleTappedCell(_:)))
//        tableView.addGestureRecognizer(tapGesture)
//        tapGesture!.delegate = self
//       
        // Do any additional setup after loading the view.
        
    }
    func doubleTappedCell () {
        
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    // MARK: - Table View methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = allItems[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < allItems.count {
            allItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
        saveChanges()
    }
    
    // MARK: - Actions
    
    @IBAction func addItem(_ sender: Any) {
        addingItem()
        saveChanges()
        
    }
    public func saveChanges() {
        print ("Saving items to: \(itemArchiveURL.path)")
        NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    func loadData() {
        if let savedData = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            self.allItems = savedData
        }
    }
    func addingItem() {
        if let itemEntered = itemField?.text {
            if itemEntered.count > 0 {
                let newItem = Item(itemEntered)
                allItems.append(newItem)
            }
          
        }
        saveChanges()
        itemField.text = ""
        tableView.reloadData()
    }
   
    @IBAction func toggleEditingMode(_ sender: Any) {
        print(#function)
        if isEditing {
            // turn off editing mode
            setEditing(false, animated: true)
        } else {
            setEditing(true, animated: true)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addingItem()
       // textField.resignFirstResponder()
        return true
    }
}
