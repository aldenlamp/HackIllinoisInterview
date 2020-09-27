//
//  File.swift
//  Hack Illinois Interview
//
//  Created by alden lamp on 9/26/20.
//  Copyright © 2020 alden lamp. All rights reserved.
//

import Foundation

import UIKit

class EventTableViewCell: UITableViewCell{
    
//    static var TITLE_CELL_HEIGHT: Int = 80
//    static var CELL_HEIGHT: Int = 250
    static var CELL_HEIGHT: Int = 100
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Testing"
        label.textColor = UIColor.black
        label.font =  UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let eventType: UILabel = {
        let label = UILabel()
        label.text = "asdfasdf"
        label.textColor = UIColor.black
        label.font =  UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        self.backgroundColor = UIColor.clear
        
        addSubview(cellView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(eventType)
        cellView.addSubview(descriptionLabel)
        
        cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.cellView.layoutMarginsGuide.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.cellView.layoutMarginsGuide.leftAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.cellView.layoutMarginsGuide.rightAnchor, constant: -5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        eventType.topAnchor.constraint(equalTo: titleLabel.bottomAnchor
        , constant: 5).isActive = true
        eventType.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 10).isActive = true
        eventType.heightAnchor.constraint(equalToConstant: 20).isActive = true
        eventType.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -10).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: eventType.bottomAnchor, constant:10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: cellView.layoutMarginsGuide.bottomAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 10).isActive = true
    }
    
    func reload(from event: EventObject){
        self.titleLabel.text = event.name
        
        self.eventType.text = "Event Type: \(event.eventType.prefix(1).capitalized + event.eventType.lowercased().dropFirst())"
        
        self.descriptionLabel.text = event.description
    }
    
    
    static func heightWithDescription(of text: String, andWidth width: Int) -> CGFloat{
        
        let maxSize = CGSize(width: CGFloat(width), height: CGFloat(Float.infinity))
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .light)], context: nil)
        return textSize.height
    
    }
    
}
