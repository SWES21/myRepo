//
//  User.swift
//  tinderCloneSwiping
//
//  Created by Michael Fitzgerald on 11/18/20.
//
//
import UIKit
struct Recommendations: Decodable{
    let recommendations: [User]
}
struct User: Decodable {
    //defining out properties for our model layer
    let id: Int
    let name: String
    let category: Int
    let rating: String
    let num_ratings: Int
    let price: Int
    let latitude: String
    let longitude: String
}



