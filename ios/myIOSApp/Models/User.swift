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
    let id: Int?
    let name: String?
    let category: Int?
    let rating: Float?
    let num_ratings: Float?
    let price: Int?
    let latitude: Double?
    let longitude: Double?
    init(dictionary: [String: Any]){
        self.id = dictionary["id"] as? Int
        self.name = dictionary["name"] as? String
        self.category = dictionary["ResturantType"] as? Int
        self.rating = dictionary["Price"] as? Float
        self.num_ratings = dictionary["Date"] as? Float
        self.price = dictionary["Image"] as? Int
        self.latitude = dictionary["lon"] as? Double
        self.longitude = dictionary["lat"] as? Double
    }
}


