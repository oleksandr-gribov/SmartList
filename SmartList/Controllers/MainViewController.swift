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
    var imageCache: ImageCache!
    
    
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
        itemField.autocapitalizationType = UITextAutocapitalizationType.words
        self.navigationItem.title = "SmartList"
       

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector (MainViewController.doubleTappedCell(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.delaysTouchesBegan = true
        
  
        tableView.addGestureRecognizer(doubleTapGesture)
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let selectedRow : IndexPath? = tableView.indexPathForSelectedRow
        if let selectedRowNotNil = selectedRow {
            tableView.deselectRow(at: selectedRowNotNil, animated: true)
        }
    }
    
    @objc func doubleTappedCell (_ recognizer: UITapGestureRecognizer) {
        
        if recognizer.state == UITapGestureRecognizer.State.ended {
            let tapLocation = recognizer.location(in: self.tableView)
            if let indexPath = self.tableView.indexPathForRow(at: tapLocation){
                let section = indexPath.section
                if let tappedCell = self.tableView.cellForRow(at: indexPath) {
                    let item = allItems[indexPath.row]
                    item.completed = !item.completed
                    toggleCheckbox(tappedCell, isCompleted: item.completed)
                    allItems.sort()
                    tableView.reloadData()
                    saveChanges()
                }
            }
        }
    }
        
    func toggleCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.accessoryType = .none
            cell.textLabel?.textColor = .black
        } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = .gray
        }
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
        cell.textLabel?.text = allItems[indexPath.row].name
       
        toggleCheckbox(cell, isCompleted: item.completed)
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   
  
    
    // Editing rows
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
            allItems.sort()
        }
    }
    func addingItem() {
        if let itemEntered = itemField?.text {
            if itemEntered.count > 0 {
                let newItem = Item(name: itemEntered)
                allItems.append(newItem)
                allItems.sort()
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
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailView" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedItem = allItems[indexPath.row]
                let destinationVC = segue.destination as! DetailViewController
                destinationVC.item = selectedItem
                destinationVC.imageCache = imageCache
            }
        }
        if segue.identifier == "barcodeSegue" {
            let destinationVC = segue.destination as! BarcodeScannerViewController
            destinationVC.imageCache = imageCache
        }
        
    }
    @IBAction func unwindToMainViewController (_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DetailViewController, let item = sourceViewController.item {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                allItems[selectedIndexPath.row] = item
                print("MainVC \(allItems[selectedIndexPath.row].name)")
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: allItems.count, section: 0)
                allItems.append(item)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        }
        saveChanges()
    }
    

}
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addingItem()
       // textField.resignFirstResponder()
        return true
    }
}
