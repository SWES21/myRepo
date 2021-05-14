//
//  moreInfoPage.swift
//  myIOSApp
//
//  Created by Michael  on 4/25/21.
//

import UIKit
import CoreLocation

class moreInfoPage: UIViewController {
    var user: User? {
        didSet{
        let myView = UILabel()
        let myImg = UIImageView()
        let resturantName = UILabel()
        let resturantType = UILabel()
        let resturantPrice = UILabel()
        let resturantAddress = UILabel()
        let resturantLonLat = UILabel()
        let menuLabel = UILabel()
        let menu = UIImageView()
        view.addSubview(myView)
        myView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        myView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        myView.text = "Detailed Information"
        myView.textAlignment = .center
        myView.backgroundColor = .systemGray3
        myView.textColor = .white
        view.addSubview(myImg)
        myImg.backgroundColor = .systemGray
        myImg.anchor(top: myView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil)
        myImg.heightAnchor.constraint(equalToConstant: 300).isActive = true
        myImg.widthAnchor.constraint(equalToConstant: 200).isActive = true
        myImg.image = UIImage(named: "type" + " \(self.user?.category ?? 0)")?.withRenderingMode(.alwaysOriginal)
        view.addSubview(resturantName)
        view.addSubview(resturantType)
        view.addSubview(resturantPrice)
        view.addSubview(resturantAddress)
        view.addSubview(resturantLonLat)
        view.addSubview(menuLabel)
        view.addSubview(menu)
        resturantName.anchor(top: myView.bottomAnchor, leading: myImg.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 7, bottom: 0, right: 0))
        resturantType.anchor(top: resturantName.bottomAnchor, leading: myImg.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 7, bottom: 0, right: 0))
        resturantPrice.anchor(top: resturantType.bottomAnchor, leading: myImg.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 7, bottom: 0, right: 0))
        resturantAddress.anchor(top: resturantPrice.bottomAnchor, leading: myImg.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 7, bottom: 0, right: 0))
        resturantAddress.numberOfLines = 0
        resturantLonLat.anchor(top: resturantAddress.bottomAnchor, leading: myImg.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 7, bottom: 0, right: 0))
        resturantLonLat.numberOfLines = 0
        menuLabel.anchor(top: myImg.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        menuLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        menu.anchor(top: menuLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil)
        menuLabel.text = "Distance: \n 26 miles"
        menuLabel.font = .italicSystemFont(ofSize: 16)
        menuLabel.textAlignment = .center
        resturantName.text = "Resturant: \(user?.name ?? "")"
            let resturantCat = user?.category ?? 0
            switch resturantCat {
            case 0:
                resturantType.text = "Type: America"
            case 1:
                resturantType.text = "Type: French"
            case 2:
                resturantType.text = "Type: Cafe"
            case 3:
                resturantType.text = "Type: Southern"
            case 4:
                resturantType.text = "Type: Italian"
            case 5:
                resturantType.text = "Type: Mexican"
            case 6:
                resturantType.text = "Type: BBQ"
            case 7:
                resturantType.text = "Type: Ice Cream"
            case 8:
                resturantType.text = "Type: Vietnamese"
            case 9:
                resturantType.text = "Type: Chinese"
            case 10:
                resturantType.text = "Type: Mediterranean"
            case 11:
                resturantType.text = "Type: Cajun"
            case 12:
                resturantType.text = "Type: Japanese"
            case 13:
                resturantType.text = "Type: Seafood"
            case 14:
                resturantType.text = "Type: Thai"
            case 15:
                resturantType.text = "Type: Caribbean"
            case 16:
                resturantType.text = "Type: Korean"
            case 17:
                resturantType.text = "Type: Szechaun"
            case 18:
                resturantType.text = "Type: Indian"
            case 19:
                resturantType.text = "Type: Brazilian"
            case 20:
                resturantType.text = "Type: Latin American"
            default:
                resturantType.text = "American"
            }
            let priceType = user?.price ?? 0
            switch priceType {
            case 0:
                resturantPrice.text = "Price: $"
            case 1:
                resturantPrice.text = "Price: $$"
            case 2:
                resturantPrice.text = "Price: $$$"
            default:
                resturantPrice.text = "Price: $"
            }
        resturantAddress.text = "Address: 2301 Rodeo Drive"
        resturantLonLat.text = "Longitude and Latitude: \(user?.longitude ??  "") \(user?.latitude ?? "")"
        resturantName.textColor = .systemGray
        resturantType.textColor = .systemGray
        resturantPrice.textColor = .systemGray
        resturantAddress.textColor = .systemGray
        resturantLonLat.textColor = .systemGray
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
