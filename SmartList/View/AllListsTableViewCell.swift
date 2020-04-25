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
        backgroundColor = .lightGray
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
        addSubview(sharedWithStack)
        sharedWithStack.addSubview(imageStack)
        sharedWithStack.addSubview(optionalLabel)

        nameLabel.setConstraints(top: topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 10, right: nil, paddingRight: 15, left: leftAnchor, paddingLeft: 15, height: 30, width: 300)
        dateLabel.setConstraints(top: nameLabel.bottomAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: nameLabel.leftAnchor, paddingLeft: 0, height: 20, width: 100)
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

    let sharedWithStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal

        return stack
    }()

    let imageStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal

        return stack
    }()

    let optionalLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "+ 3"

        return lbl
    }()

}

extension UIView {
    func setConstraints(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?,paddingBottom: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat,  height: CGFloat, width: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    
}
