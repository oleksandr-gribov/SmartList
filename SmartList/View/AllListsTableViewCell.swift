//
//  AllListsTableViewCell.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 4/24/20.
//  Copyright © 2020 Oleksandr Gribov. All rights reserved.
//

import UIKit

class AllListsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .gray
        setupViews()
    }
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {

    }

    func setupData() {

    }
    func setupViews() {
        addSubview(nameLabel)
        addSubview(dateLabel)
        //addSubview(accessVStack)
       addSubview(topLabel)
       addSubview(imageStack)
        imageStack.addArrangedSubview(firstImageView)
        imageStack.addArrangedSubview(secondImageView)
        imageStack.addArrangedSubview(thirdImageView)
        addSubview(moreUsersLabel)
      
       // setupAccessStack()
        
        //bringSubviewToFront(accessVStack)
        
//        accessVStack.setConstraints(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: nameLabel.rightAnchor, paddingLeft: 10, height: 80, width: 180)
//        accessVStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        nameLabel.setConstraints(top: topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 10, right: nil, paddingRight: 15, left: leftAnchor, paddingLeft: 15, height: 30, width: 200)
        dateLabel.setConstraints(top: nameLabel.bottomAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: nameLabel.leftAnchor, paddingLeft: 0, height: 20, width: 100)
        
        topLabel.setConstraints(top: nameLabel.topAnchor, paddingTop: 0, bottom: nameLabel.bottomAnchor, paddingBottom: 0, right: rightAnchor, paddingRight: 10, left: nameLabel.rightAnchor, paddingLeft: 10, height: 0, width: 0)
        imageStack.setConstraints(top: topLabel.bottomAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: topLabel.leftAnchor, paddingLeft: 0, height: 30, width: 100)
        moreUsersLabel.setConstraints(top: topLabel.bottomAnchor, paddingTop: 5, bottom: imageStack.bottomAnchor, paddingBottom: 0, right: topLabel.rightAnchor, paddingRight: 0, left: imageStack.rightAnchor, paddingLeft: 5, height: 0, width: 0)
        
              
    }
    func setupAccessStack() {
        accessVStack.addArrangedSubview(topLabel)
        accessVStack.addArrangedSubview(bottomAccessStack)
        
        imageStack.addArrangedSubview(firstImageView)
        imageStack.addArrangedSubview(secondImageView)
        imageStack.addArrangedSubview(thirdImageView)
        firstImageView.setConstraints(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, height: 30, width: 30)
        
        secondImageView.setConstraints(top: imageStack.topAnchor, paddingTop: 5, bottom: imageStack.bottomAnchor, paddingBottom: 5, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, height: 30, width: 30)
        thirdImageView.setConstraints(top: imageStack.topAnchor, paddingTop: 5, bottom: imageStack.bottomAnchor, paddingBottom: 5, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, height: 30, width: 30)
       
        bottomAccessStack.addArrangedSubview(imageStack)
        bottomAccessStack.addArrangedSubview(moreUsersLabel)
        //imageStack.centerYAnchor.constraint(equalTo: bottomAccessStack.centerYAnchor).isActive = true
        
//        imageStack.setConstraints(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, height: 20, width: 0)
    }

    let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Kroger shopping"
        lbl.backgroundColor = .green
        return lbl
    }()

    let dateLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "12/04/2020"
        lbl.textColor = .gray
        lbl.backgroundColor = .yellow
        return lbl
    }()

    let optionalLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "+ 3"

        return lbl
    }()
    
    let accessVStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .blue
        stack.distribution = .fillEqually
        return stack
    }()
    
    let bottomAccessStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .red
        stack.distribution = .fillEqually
        return stack
    }()
    
    let imageStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
    
    let topLabel :  UILabel = {
        let lbl = UILabel()
        lbl.text = "Shared With"
        lbl.backgroundColor = .purple
        lbl.textAlignment = .left
        return lbl
    }()
    
    let moreUsersLabel :  UILabel = {
        let lbl = UILabel()
        lbl.text = "+3 more"
        return lbl
    }()
    
    let firstImageView : UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        iv.layer.cornerRadius = iv.frame.height / 2
        iv.backgroundColor = .blue
        iv.clipsToBounds = true
        return iv
    }()
    
    let secondImageView : UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        iv.layer.cornerRadius = iv.frame.height / 2
        iv.backgroundColor = .yellow
        iv.clipsToBounds = true
        return iv
    }()
    
    let thirdImageView : UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        iv.layer.cornerRadius = iv.frame.height / 2
        iv.backgroundColor = .orange
        iv.clipsToBounds = true
        return iv
    }()

}

