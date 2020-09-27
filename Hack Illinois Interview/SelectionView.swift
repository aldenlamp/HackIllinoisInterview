//
//  SelectionView.swift
//  Hack Illinois Interview
//
//  Created by alden lamp on 9/26/20.
//  Copyright © 2020 alden lamp. All rights reserved.
//

import Foundation
import UIKit

protocol SelectionViewDelegate {
    func update()
}


class SelectionView: UIView{
    
    var items: [String] = []
    
    var currIndex = 0
    
    let currentSelection: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.font =  UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(">", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return button
    }()
    
    let leftButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("<", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return button
    }()
    
    init(items: [String]) {
        super.init(frame: CGRect())
        self.items = items
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        currentSelection.text = items.count > 0 ? items[currIndex] : ""
        rightButton.addTarget(self, action: #selector(moveRight), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(moveLeft), for: .touchUpInside)
        
        addSubview(currentSelection)
        addSubview(rightButton)
        addSubview(leftButton)
        
        
    }
    
    @objc func moveRight() {

    }
    
    @objc func moveLeft() {
        
    }
    
    
    
    
}
