
//
//  SignUpPageSignUp.swift
//  Created by Michael  on 1/6/21.
//

import UIKit
import JGProgressHUD
import CoreLocation
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
class EditProfile: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    var filteredData = ["America","French","Cafe","Southern","Italian","Mexican","BBQ","Ice Cream","Vietnamese","Chinese","Mediterranean","Cajun","Japanese","Seafood","Thai","Caribbean","Korean","Szechaun","Indian","Brazilian", "Latin American","Price: $","Price: $$","Price: $$$"]
    var homeValue:CLLocation?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let cell =  tableView.cellForRow(at: indexPath) as! TableViewCell
        let row = indexPath.row
        if cell.count == 1{
            cell.count = 0
            array[row] = 100
        }else{
            cell.count = 1
            array[row] = row
        }
    }
    var array = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    var milesReturn = 25
    override func viewDidDisappear(_ animated: Bool) {
        var semaphore = DispatchSemaphore (value: 0)
        let parameters = ""
        let postData =  parameters.data(using: .utf8)
        print(array)
       // let urlTwo = URL(string: "https://csds393.herokuapp.com/api/user/recommendations/get")
        var request = URLRequest(url: URL(string: "https://csds393.herokuapp.com/api/user/recommendations/get")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.httpBody = postData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    //the table view is used to show the cells in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        cell.myLabel.text = filteredData[indexPath.row]
        cell.count = 1
        return cell
    }
    let screenSize: CGRect = UIScreen.main.bounds
    lazy var screenWidth = screenSize.width
    let tblView = UITableView()
    let miles = UILabel()
    let slider = UISlider()
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        tblView.register(TableViewCell.self, forCellReuseIdentifier: "id")
        tblView.separatorStyle = .singleLine
        tblView.dataSource = self
        tblView.delegate = self
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    fileprivate func setupLayout() {
    //this creates a background color
    view.backgroundColor = .white
    let topView = UIView()
    let bottomView = UIView()
    let img = UIImageView()
        view.addSubview(topView)
        view.addSubview(bottomView)
        view.addSubview(img)
        view.addSubview(slider)
        view.addSubview(miles)
        view.addSubview(tblView)
        //This creates the top view contorller
        topView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        topView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        bottomView.anchor(top: nil, leading: view.leadingAnchor, bottom: topView.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        bottomView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomView.backgroundColor = .systemGray6
        img.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: screenWidth/2-30, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        miles.anchor(top: topView.bottomAnchor, leading: img.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0),size: .init(width: 100, height: 50))
        miles.text = "25 miles"
        img.image?.withRenderingMode(.alwaysOriginal)
        img.image = APPURL.imageHead
        img.clipsToBounds = true
        img.layer.cornerRadius = 25
        slider.anchor(top: miles.bottomAnchor, leading: miles.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: -40, bottom: 0, right: 0),size: .init(width: 150, height: 40))
        slider.addTarget(self, action: #selector(hitSlider), for: .allEvents)
        slider.minimumValue = 25
        slider.maximumValue = 100
        tblView.anchor(top: slider.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        homeValue = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
    }
    @objc fileprivate func hitSlider(){
        miles.text = String(Int(slider.value)) + " miles"
    }
}


