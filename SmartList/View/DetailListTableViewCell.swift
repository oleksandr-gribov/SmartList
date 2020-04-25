//
//  DetailListTableViewCell.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 4/24/20.
//  Copyright © 2020 Oleksandr Gribov. All rights reserved.
//

import UIKit

class DetailListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .lightGray
        setupViews()
    }
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    func setupViews() {
        backgroundColor = .white
        addSubview(nameLabel)
        addSubview(checkbox)
        addSubview(myimageView)
        
         
        checkbox.setConstraints(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: leftAnchor, paddingLeft: 10, height: 20, width: 20)
        checkbox.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        myimageView.setConstraints(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: leftAnchor, paddingLeft: 10, height: 20, width: 20)
        myimageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        nameLabel.setConstraints(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: checkbox.rightAnchor, paddingLeft: 10, height: 40, width: 300)
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    let nameLabel : UILabel = {
           let lbl = UILabel()
           lbl.text = "Kroger shopping"
        lbl.font = UIFont(name: "AvenirNext-Bold", size: 18)
           return lbl
       }()
    
    let checkbox: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.layer.cornerRadius = view.frame.height/2
        view.clipsToBounds =  true
        view.layer.borderColor = UIColor(displayP3Red: 255/255, green: 186/255, blue: 90/255, alpha: 1.0).cgColor
        view.layer.borderWidth = 2
        view.backgroundColor = .white
        
        return view
    }()
    
    let myimageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "checkmark")
        iv.contentMode = .scaleAspectFit
        iv.isHidden = true
        return iv
    }()

}
