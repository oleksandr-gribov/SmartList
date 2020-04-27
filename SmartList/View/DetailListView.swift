//
//  DetailListView.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 4/24/20.
//  Copyright © 2020 Oleksandr Gribov. All rights reserved.
//

import UIKit

class DetailListView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .white
            //UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(tableView)
        addSubview(textField)
        addSubview(addButton)
        textField.addSubview(barcodeButton)
        //119,255,170
        textField.addBottomLine(UIColor(displayP3Red: 119/255, green: 255/255, blue: 170/255, alpha: 1.0))
        
        textField.setConstraints(top: topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, height: 60, width: 350)
        textField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //addButton.setConstraints(top: topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, right: rightAnchor, paddingRight: 10, left: textField.rightAnchor, paddingLeft: 10, height: 60, width: 0)
        tableView.setConstraints(top: textField.bottomAnchor, paddingTop: 20, bottom: bottomAnchor, paddingBottom: 10, right: rightAnchor, paddingRight: 10, left: leftAnchor, paddingLeft: 10, height: 0, width: 0)
        barcodeButton.setConstraints(top: nil, paddingTop: 2, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: textField.leftAnchor, paddingLeft: 10, height: 45, width: 40)
        barcodeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
    }
    
    let tableView : UITableView = {
        let tv = UITableView()
//        tv.backgroundColor = .blue
            //UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 0.7)
        tv.layer.cornerRadius = 10
        tv.backgroundColor = .white
            //UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        tv.clipsToBounds = true
        return tv
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        
        tf.borderStyle = .none
        tf.backgroundColor = UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
            //UIColor(displayP3Red: 255/255, green: 253/255, blue: 243/255, alpha: 1.0)
      
        tf.placeholder = "Add Item"
        tf.textAlignment = .center
        tf.layer.cornerRadius = 10
        
        return tf
    }()
    
    let barcodeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "barcode"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let addButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add", for: .normal)
        btn.backgroundColor = UIColor(displayP3Red: 255/255, green: 186/255, blue: 90/255, alpha: 1.0)
        btn.layer.cornerRadius = 10
        
        return btn
    }()
    
}


