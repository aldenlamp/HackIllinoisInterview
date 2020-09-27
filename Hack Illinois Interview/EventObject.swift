//
//  EventObject.swift
//  Hack Illinois Interview
//
//  Created by alden lamp on 9/26/20.
//  Copyright © 2020 alden lamp. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

struct EventObject {
    
    var id : String
    var name : String
    var description : String
    var startTime : Int
    var endTime : Int
    var locations : [String]
    var sponsor : String
    var eventType : String
    
    init(json : [String : Any]) throws {
        guard let name = json["name"] as? String else{
            throw SerializationError.missing("name")
        }
        
        guard let id = json["id"] as? String else{
            throw SerializationError.missing("id")
        }
        
        guard let description = json["description"] as? String else{
            throw SerializationError.missing("description")
        }
        
        guard let startTime = json["startTime"] as? Int else{
            throw SerializationError.missing("startTime")
        }
        
        guard let endTime = json["endTime"] as? Int else{
            throw SerializationError.missing("endTime")
        }
        
        guard let locations = json["locations"] as? [String] else{
            throw SerializationError.missing("location")
        }
        
        
        guard let sponsor = json["sponsor"] as? String else{
            throw SerializationError.missing("sponsor")
        }
        
        guard let eventType = json["eventType"] as? String else{
            throw SerializationError.missing("eventType")
        }
        
        
        self.id = id
        self.name = name
        self.description = description
        self.startTime = startTime
        self.endTime = endTime
        self.locations = locations
        self.sponsor = sponsor
        self.eventType = eventType
    }
    
    private func getTime(startTime: Bool, withFormat formattingString: String) -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(startTime ? self.startTime : self.endTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formattingString
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
        
    }
    
    func getStartTimeString (fromFormat formattingString: String = "MMM dd, hh:mm a") -> String{
        return getTime(startTime: true, withFormat: formattingString)
    }
    
    func getEndTimeString (froFormat formattingString: String = "MMM dd, hh:mm a") -> String{
        return getTime(startTime: false, withFormat: formattingString)
    }
    
}
