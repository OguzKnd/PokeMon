//
//  SideBarCell.swift
//  PokeMon
//
//  Created by Oğuz Kanda on 18.01.2024.
//

import Foundation
import UIKit

class SideBarCell: UITableViewCell {
    
    let cardView: UIView = {
       let view = UIView()
       view.layer.cornerRadius = 14
       view.backgroundColor = .white
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    let usernameLabel: UILabel = {
       let label = UILabel()
       label.text = "@itsdanielkioko"
       label.textAlignment = .center
       label.font = UIFont.systemFont(ofSize: 14)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.addSubview(usernameLabel)
        
        addSubview(cardView)
        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 12).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }
    
    override init(style: SideBarCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: "ccell")
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


    
    




