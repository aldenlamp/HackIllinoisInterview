//
//  DataParser.swift
//  Hack Illinois Interview
//
//  Created by alden lamp on 9/26/20.
//  Copyright © 2020 alden lamp. All rights reserved.
//

import Foundation

class DataParser{
    
    var sortedEvents: [[EventObject]] = []
    var groupedEvents: [[[EventObject]]] = []
    var dates : [String] = []
    
    init(){
        if let url = URL(string: "https://api.hackillinois.org/event/") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let jsonData = json["events"] as! [[String : Any]]
                        
                        for eventMap in jsonData{
                            do{
                                let eventObj = try EventObject(json: eventMap )
                                
                                var matchedTime = false
                                for eventTimeGroupsIndex in 0..<self.sortedEvents.count{
                                    if eventObj.startTime == self.sortedEvents[eventTimeGroupsIndex][0].startTime{
                                        self.sortedEvents[eventTimeGroupsIndex].append(eventObj)
                                        matchedTime = true
                                    }
                                }
                                if !matchedTime{
                                    self.sortedEvents.append([eventObj])
                                }
                            }catch{
                                print(error)
                            }
                        }
                        
                        self.sortEvents()
                    }
                }
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .didReceiveData, object: nil)
                }
            }.resume()
        }
    }
    
    func sortEvents(){
        
        for i in 0..<sortedEvents.count{
            var indexOfTime = i
            var minTime = sortedEvents[i][0].startTime
            for j in i..<sortedEvents.count{
                if sortedEvents[j][0].startTime < minTime{
                    indexOfTime = j
                    minTime = sortedEvents[j][0].startTime
                }
            }
            if i != indexOfTime{
                let temp = sortedEvents[i]
                sortedEvents[i] = sortedEvents[indexOfTime]
                sortedEvents[indexOfTime] = temp
            }
        }
    }
    
    func groupEvents(){
        sortEvents()
        var currentDate = ""
        for i in 0..<sortedEvents.count{
            let eventDate = sortedEvents[i][0].getStartTimeString(fromFormat: "MMM dd")
            if eventDate == currentDate {
                groupedEvents[groupedEvents.count - 1].append(sortedEvents[i])
            }else{
                groupedEvents.append([sortedEvents[i]])
                currentDate = sortedEvents[i][0].getStartTimeString(fromFormat: "MMM dd")
                dates.append(currentDate)
            }
        }
    }
}
