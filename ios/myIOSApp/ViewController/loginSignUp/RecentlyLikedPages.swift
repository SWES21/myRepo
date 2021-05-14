//
//  RecentlyLikedPages.swift
//  myIOSApp
//
//  Created by Michael  on 5/14/21.
//

import UIKit
import Contacts
import CoreLocation
class RecentlyLikedPages: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myModel.count
    }
    let myModel = APPURL.UserModel
    let tblview = UITableView()
    let topView = UILabel()
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
    func getAddress(location: CLLocation) -> String {
            let address: String = ""
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            //selectedLat and selecedLon are double values set by the app in a previous process
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

                // Place details
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]

                // Address dictionary
                //print(placeMark.addressDictionary ?? "")

                // Location name
                if (placeMark.addressDictionary!["Name"] as? NSString) != nil {
                    //print(locationName)
                }

                // Street address
                if (placeMark.addressDictionary!["Thoroughfare"] as? NSString) != nil {
                    //print(street)
                }

                // City
                if (placeMark.addressDictionary!["City"] as? NSString) != nil {
                    //print(city)
                }

                // Zip code
                if (placeMark.addressDictionary!["ZIP"] as? NSString) != nil {
                    //print(zip)
                }

                // Country
                if (placeMark.addressDictionary!["Country"] as? NSString) != nil {
                    //print(country)
                }

            })

            return address;
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblview.dequeueReusableCell(withIdentifier: "id1", for: indexPath)
        let location = CLLocation()
        cell.selectionStyle = .none
        cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
        let img = UIImageView()
        img.image = UIImage(named:"type \(String(myModel[indexPath.row].category))")
        cell.addSubview(img)
        img.backgroundColor = .gray
        img.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 0, right: 0))
        img.heightAnchor.constraint(equalToConstant: 50).isActive = true
        img.widthAnchor.constraint(equalToConstant: 50).isActive = true
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        let title = UILabel()
        cell.addSubview(title)
        title.anchor(top: img.topAnchor, leading: img.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 10, bottom: 0, right: 0))
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
        title.text = "\(myModel[indexPath.row].name) ,type: \(label) \n address: \(myModel[indexPath.row].price)"
        return cell
    }
}
