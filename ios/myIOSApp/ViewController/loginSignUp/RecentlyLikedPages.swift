//
//  RecentlyLikedPages.swift
//  myIOSApp
//
//  Created by Michael  on 5/14/21.
//

import UIKit
import Contacts
import CoreLocation
//this is used in order to createa place
extension CLPlacemark {
    var compactAddress: String? {
        if let name = name {
            var result = name

            if let street = thoroughfare {
                result += ", \(street)"
            }

            if let city = locality {
                result += ", \(city)"
            }

            if let country = country {
                result += ", \(country)"
            }

            return result
        }

        return nil
    }

}
//This is used in order to create delegates in order to create
class RecentlyLikedPages: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myModel.count
    }
    let myModel = APPURL.UserModel
    let tblview = UITableView()
    let topView = UILabel()
    //this is executed when loeaded
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tblview)
        tblview.register(UITableViewCell.self, forCellReuseIdentifier: "id1")
        tblview.separatorStyle = .singleLine
        tblview.dataSource = self
        tblview.delegate = self
        view.addSubview(topView)
        topView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        topView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        tblview.anchor(top: topView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        view.backgroundColor = .white
        topView.text = "Recently Liked"
        topView.textAlignment = .center
    }
    //the table view is used in order to create the cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell is used in order to create the
        let cell = tblview.dequeueReusableCell(withIdentifier: "id1", for: indexPath)
        //the location is used in order to create
        let location = CLLocation(latitude: Double(myModel[indexPath.row].latitude) ?? 0.0, longitude: Double(myModel[indexPath.row].longitude) ?? 0.0)
        let geocoder = CLGeocoder()
        cell.selectionStyle = .none
        cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
        let img = UIImageView()
        //The is used to select the category 
        img.image = UIImage(named:"type \(String(myModel[indexPath.row].category))")
        cell.addSubview(img)
        img.backgroundColor = .gray
        img.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 25, left: 10, bottom: 0, right: 0))
        img.heightAnchor.constraint(equalToConstant: 50).isActive = true
        img.widthAnchor.constraint(equalToConstant: 50).isActive = true
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        let title = UILabel()
        cell.addSubview(title)
        title.anchor(top: img.topAnchor, leading: img.trailingAnchor, bottom: nil, trailing: cell.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        title.numberOfLines = 0
        let resturantCat = myModel[indexPath.row].category
        var label = ""
        switch resturantCat {
        case 0:
            label = "America"
        case 1:
            label = "French"
        case 2:
            label = "Cafe"
        case 3:
            label = "Southern"
        case 4:
            label = "Italian"
        case 5:
            label = "Mexican"
        case 6:
            label = "BBQ"
        case 7:
            label = "Ice Cream"
        case 8:
            label = "Vietnamese"
        case 9:
            label = "Chinese"
        case 10:
            label = "Mediterranean"
        case 11:
            label = "Cajun"
        case 12:
            label = "Japanese"
        case 13:
            label = "Seafood"
        case 14:
            label = "Thai"
        case 15:
            label = "Caribbean"
        case 16:
            label = "Korean"
        case 17:
            label = "Szechaun"
        case 18:
            label = "Indian"
        case 19:
            label = "Brazilian"
        case 20:
            label = "Latin American"
        default:
            label = "American"
        }
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        // Process Response
        let postalAddressFormatter = CNPostalAddressFormatter()
        postalAddressFormatter.style = .mailingAddress
        var addressString: String?
        if let postalAddress = placemarks?.first?.postalAddress {
            addressString = postalAddressFormatter.string(from: postalAddress)
            title.text = "\(self.myModel[indexPath.row].name) Type: \(label) \nAddress: \(addressString!)"
        }
        }
        title.font = .systemFont(ofSize: 14)
        return cell
    }
    override func viewDidAppear(_ animated: Bool) {
        tblview.reloadData()
    }
}
