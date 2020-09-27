//
//  ViewController.swift
//  Hack Illinois Interview
//
//  Created by alden lamp on 9/24/20.
//  Copyright © 2020 alden lamp. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let didReceiveData = Notification.Name("didRecievedData")
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var eventData: DataParser = DataParser()
    var selectionView: SelectionView = SelectionView()
    
    let tableview: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .grouped)
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.recievedData), name: .didReceiveData, object: nil)
        
        
        assignbackground()
        setUpView()
    }
        
    func assignbackground(){
        let background = UIImage(named: "background.png")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        imageView.alpha = 0.75
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    @objc func recievedData(){
        selectionView = SelectionView(items: eventData.dates)
        tableview.reloadData()
    }
    
    
    func setUpView(){
        
//        view.addSubview(selectionView)
//        selectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
//        selectionView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
//        selectionView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
//        selectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true


        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.backgroundColor = UIColor.clear
        
        tableview.register(EventTableViewCell.self, forCellReuseIdentifier: "cellID")
        view.addSubview(tableview)
        
        tableview.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
//        tableview.topAnchor.constraint(equalTo: selectionView.bottomAnchor, constant: 20).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        tableview.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let timeLabel = UILabel()
        
        timeLabel.backgroundColor = UIColor.clear
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        timeLabel.text = eventData.sortedEvents[section][0].getStartTimeString()
        timeLabel.textColor = UIColor.black
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(timeLabel)
        
        timeLabel.leftAnchor.constraint(equalTo: headerView.layoutMarginsGuide.leftAnchor, constant: 10).isActive = true
        
        timeLabel.rightAnchor.constraint(equalTo: headerView.layoutMarginsGuide.rightAnchor, constant: -10).isActive = true
        
        timeLabel.bottomAnchor.constraint(equalTo: headerView.layoutMarginsGuide.bottomAnchor).isActive = true
        
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return EventTableViewCell.heightWithDescription(of: eventData.sortedEvents[indexPath.section][indexPath.row].description, andWidth: Int(self.tableview.frame.width - 50)) + CGFloat(EventTableViewCell.CELL_HEIGHT) + 25
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventData.sortedEvents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventData.sortedEvents[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! EventTableViewCell
        cell.reload(from: eventData.sortedEvents[indexPath.section][indexPath.row])
//        cell.titleLabel.text = eventData.sortedEvents[indexPath.section][indexPath.row].name
        return cell
    }


}


