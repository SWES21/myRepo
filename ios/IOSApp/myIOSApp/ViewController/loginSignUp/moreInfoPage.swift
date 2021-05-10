//
//  moreInfoPage.swift
//  myIOSApp
//
//  Created by Michael  on 4/25/21.
//

import UIKit

class moreInfoPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    fileprivate func setupLayout(){
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
        myImg.image = UIImage(named: "Image-1")
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
        menuLabel.text = "Menu:"
        menuLabel.font = .italicSystemFont(ofSize: 16)
        menuLabel.textAlignment = .center
        resturantName.text = "Resturant: Del Rio"
        resturantType.text = "Type: Mexican"
        resturantPrice.text = "Price: $$$"
        resturantAddress.text = "Address: 15901 RosemontFarm.Pl Waterford VA"
        resturantLonLat.text = "Longitude and Latitude: 13.5 ,18.132"
        resturantName.textColor = .systemGray
        resturantType.textColor = .systemGray
        resturantPrice.textColor = .systemGray
        resturantAddress.textColor = .systemGray
        resturantLonLat.textColor = .systemGray
    }
}
