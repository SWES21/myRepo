//
//  User.swift
//  tinderCloneSwiping
//
//  Created by Michael Fitzgerald on 11/18/20.
//
//
import UIKit
struct User {
    //defining out properties for our model layer
    let resturantID: String?
    let Name: String?
    let ResturantType: String?
    let Price: Int?
    let Date: NSDate?
    let Image: String?
    let lon: Double?
    let lat: Double?
    init(dictionary: [String: Any]){
        self.resturantID = dictionary["resturantID"] as? String
        self.Name = dictionary["Name"] as? String
        self.ResturantType = dictionary["ResturantType"] as? String
        self.Price = dictionary["Price"] as? Int
        self.Date = dictionary["Date"] as? NSDate
        self.Image = dictionary["Image"] as? String
        self.lon = dictionary["lon"] as? Double
        self.lat = dictionary["lat"] as? Double
    }
}


