//
//  ItemView.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 4/27/20.
//  Copyright © 2020 Oleksandr Gribov. All rights reserved.
//

import UIKit

class ItemView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
            //UIColor(displayP3Red: 253/255, green: 246/255, blue: 244/255, alpha: 1.0)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(backgroundCard)
        addSubview(itemImageView)
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(brandLabel)
        addSubview(brandTextField)
        addSubview(quantityLabel)
        addSubview(quantityTextField)
        
        
        backgroundCard.setConstraints(top: topAnchor, paddingTop: 60, bottom: bottomAnchor, paddingBottom: 50, right: rightAnchor, paddingRight: 20, left: leftAnchor, paddingLeft: 20, height: 0, width: 0)
        
        nameLabel.setConstraints(top: topAnchor, paddingTop: 80, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: itemImageView.leftAnchor, paddingLeft: -20, height: 45, width: 100)
        nameTextField.setConstraints(top: nameLabel.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, right: itemImageView.rightAnchor, paddingRight: -20, left: nameLabel.rightAnchor, paddingLeft: 10 , height: 45, width: 0)

        brandLabel.setConstraints(top: nameLabel.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: nameLabel.leftAnchor, paddingLeft: 0, height: 45, width: 100)
        brandTextField.setConstraints(top: brandLabel.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, right: itemImageView.rightAnchor, paddingRight: -20, left: brandLabel.rightAnchor, paddingLeft: 10 , height: 45, width: 0)

        quantityLabel.setConstraints(top: brandLabel.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: nameLabel.leftAnchor, paddingLeft: 0, height: 45, width: 100)
        quantityTextField.setConstraints(top: quantityLabel.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, right: itemImageView.rightAnchor, paddingRight: -20, left: brandLabel.rightAnchor, paddingLeft: 10 , height: 45, width: 0)
        
        itemImageView.setConstraints(top: quantityLabel.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, height: 350, width: 320)
        itemImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        
        
        
    }
    let itemImageView : UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: 350, height: 300)
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        
        return iv
    }()
    
    let backgroundCard : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        //view.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Item: "
        lbl.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return lbl
    }()
    
    let nameTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Milk"
        tf.textAlignment = .center
        tf.addBottomLine(UIColor(displayP3Red: 119/255, green: 255/255, blue: 170/255, alpha: 1.0))

        return tf
    }()
    
    let brandLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Brand: "
        lbl.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return lbl
    }()
    
    let brandTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Kroger Store Brand"
        tf.addBottomLine(UIColor(displayP3Red: 119/255, green: 255/255, blue: 170/255, alpha: 1.0))
        tf.textAlignment = .center
        return tf
    }()
    let quantityLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Quantity: "
        lbl.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return lbl
    }()
    
    let quantityTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "2 gallons"
        tf.addBottomLine(UIColor(displayP3Red: 119/255, green: 255/255, blue: 170/255, alpha: 1.0))
        tf.textAlignment = .center
        return tf
    }()
}
