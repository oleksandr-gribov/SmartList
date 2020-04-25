//
//  MainViewController.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 3/22/19.
//  Copyright © 2019 Oleksandr Gribov. All rights reserved.
//

import UIKit

class DetailListViewContoller: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var allItems =  [Item]()
    var testItems = [Item]()
    var imageCache: ImageCache!
    var listView: DetailListView!
    var tableView: UITableView!
    let listCellIdentifier = "listCellIdentifier"
    
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    @IBOutlet var itemField: UITextField!
    
    // MARK: - Life Cycle
  
    func setupView() {
        //255,255,242
        view.backgroundColor = .white
            //UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        let mainView = DetailListView()
      
        view.addSubview(mainView)
        view.bringSubviewToFront(mainView)
        self.listView = mainView
        self.tableView = mainView.tableView
        self.tableView.register(DetailListTableViewCell.self, forCellReuseIdentifier: listCellIdentifier)
        mainView.setConstraints(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10, bottom: view.bottomAnchor, paddingBottom: 15, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, height: 0, width: 0)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        testItems.append(Item(name: "Juice"))
        testItems.append(Item(name: "Coffee"))
        testItems.append(Item(name: "Water"))
        testItems.append(Item(name: "Coke"))
        testItems.append(Item(name: "Cheese"))
        testItems.append(Item(name: "Yogurt"))
        testItems.append(Item(name: "Milk"))
        testItems.append(Item(name: "Bread"))
        
        self.navigationController?.hidesBarsOnSwipe = false
        
        self.imageCache = ImageCache()
        setupView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareListTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        //self.tableView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: -5)
        
        loadData()
        listView.textField.delegate = self
        listView.textField.autocapitalizationType = UITextAutocapitalizationType.words
        self.navigationItem.title = "SimpleList"
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: listCellIdentifier)

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector (DetailListViewContoller.doubleTappedCell(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.delaysTouchesBegan = true
        

        
        
        tableView.addGestureRecognizer(doubleTapGesture)
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: self.navigationItem.title, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
        
    }
    @objc func shareListTapped() {
        
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
                if let tappedCell = self.tableView.cellForRow(at: indexPath)as? DetailListTableViewCell{
                    let item = testItems[indexPath.section]
                    item.completed = !item.completed
                    toggleCheckbox(tappedCell, isCompleted: item.completed)
                    testItems.sort()
                    tableView.reloadData()
                    saveChanges()
                }
            }
        }
    }
    
  
        
    func toggleCheckbox(_ cell: DetailListTableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.checkbox.isHidden = false
            cell.myimageView.isHidden = true
            cell.nameLabel.textColor = .black
            cell.nameLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
        } else {
            cell.checkbox.isHidden = true
            cell.myimageView.isHidden = false
            cell.nameLabel.textColor = .gray
            cell.nameLabel.font = UIFont(name: "AvenirNext-Medium", size: 18)
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    // MARK: - Table View methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentifier, for: indexPath) as! DetailListTableViewCell
        if indexPath.section < testItems.count {
            let item = testItems[indexPath.section]
            print(item.name)
            cell.nameLabel.text = item.name
            toggleCheckbox(cell, isCompleted: item.completed)
        }
        
//        cell.backgroundColor = .white
            //UIColor(displayP3Red: 255/255, green: 253/255, blue: 243/255, alpha: 1.0)
            //UIColor(displayP3Red: 253/255, green: 246/255, blue: 244/255, alpha: 1.0)
            //255,253,243
        
//        cell.layer.cornerRadius = 10
       
        
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if testItems.count < 8 {
            return 20
        }
        return testItems.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        //119,255,170
        view.backgroundColor =  UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        //view.backgroundColor = UIColor(displayP3Red: 255/255, green: 186/255, blue: 90/255, alpha: 1.0)
        
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    // Editing rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section < allItems.count {
            allItems.remove(at: indexPath.section)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
        saveChanges()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = allItems[indexPath.section]
        let vc = ItemViewController()
        vc.item = item
        self.navigationController?.pushViewController(vc, animated: true)
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
        if let itemEntered = listView.textField.text {
            if itemEntered.count > 0 {
                let newItem = Item(name: itemEntered)
                testItems.append(newItem)
                testItems.sort()
            }
          
        }
        saveChanges()
        listView.textField.text = ""
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
                let destinationVC = segue.destination as! ItemViewController
                destinationVC.item = selectedItem
                destinationVC.imageCache = imageCache
            }
        }
        if segue.identifier == "barcodeSegue" {
            let destinationVC = segue.destination as! BarcodeScannerViewController
            destinationVC.imageCache = imageCache
        }
        
    }
    

}
extension DetailListViewContoller : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addingItem()
       // textField.resignFirstResponder()
        return true
    }
}

extension UIViewController {
    var topbarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            // Fallback on earlier versions
            return 0
        }
    }
}
