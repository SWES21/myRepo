
//
//  SignUpPageSignUp.swift
//  Created by Michael  on 1/6/21.
//

import UIKit
import JGProgressHUD
import CoreLocation
protocol signedUpTwo {
    func removed()
    func signUpHit()
}
class EditProfile: UIViewController, CLLocationManagerDelegate, ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        print("")
    }
    
    let myImage = UIButton()
    var delegate: signedUpTwo?
    let username = UITextField()
    let email = UITextField()
    let phoneNumber =  UITextField()
    let signUp = UIButton(type: .system)
    let selectImageLabel = UILabel()
    var imagePicker: ImagePicker!
    let registeringHUD = JGProgressHUD(style: .dark)
    var booleanImageHit = false
    var locationManager = CLLocationManager()
    var lon: Double?
    var lat: Double?
    var location:CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        setupLayout()
    }
 
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        lon = locValue.longitude
//        lat = locValue.latitude
//        location = locValue
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        //thse are the fields
        let screenSize = UIScreen.main.bounds
        let ScreenWidth = screenSize.width
        let myImg = UIImage(systemName: "arrow.left")
        let SelectDateLabel = UITextField()
        //create subviews
        view.addSubview(myImage)
        view.addSubview(SelectDateLabel)
        view.addSubview(username)
        view.addSubview(email)
        view.addSubview(phoneNumber)
        myImage.addSubview(selectImageLabel)
        view.addSubview(signUp)
        //targets
        myImage.addTarget(self, action: #selector(ImageHit), for: .touchUpInside)
        signUp.addTarget(self, action: #selector(signUpHit), for: .touchUpInside)
        //the targets are added
        email.autocapitalizationType = .none
        phoneNumber.autocapitalizationType = .none
        username.autocapitalizationType = .none
        myImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        myImage.heightAnchor.constraint(equalToConstant: 350).isActive = true
        myImage.layer.cornerRadius = 3
        myImage.layer.borderWidth = 3
        myImage.layer.borderColor = UIColor.systemGray2.cgColor
        selectImageLabel.anchor(top: myImage.topAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 180, left: ScreenWidth/3.7, bottom: 0, right: 0))
        selectImageLabel.text = "Add an image"
        username.anchor(top: myImage.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        username.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: username.frame.height))
        username.leftViewMode = .always
        username.heightAnchor.constraint(equalToConstant: 35).isActive = true
        username.placeholder = "Username(4-10 characters unique)"
        username.layer.cornerRadius = 6
        username.layer.borderWidth = 2
        username.layer.borderColor = UIColor.darkGray.cgColor
        email.anchor(top: username.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        email.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: email.frame.height))
        email.leftViewMode = .always
        email.heightAnchor.constraint(equalToConstant: 35).isActive = true
        email.placeholder = "Email"
        email.layer.cornerRadius = 6
        email.layer.borderWidth = 2
        email.layer.borderColor = UIColor.darkGray.cgColor
        phoneNumber.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: phoneNumber.frame.height))
        phoneNumber.leftViewMode = .always
        phoneNumber.anchor(top: email.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        phoneNumber.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: phoneNumber.frame.height))
        phoneNumber.anchor(top: email.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        phoneNumber.heightAnchor.constraint(equalToConstant: 35).isActive = true
        phoneNumber.placeholder = "Password"
        phoneNumber.layer.cornerRadius = 6
        phoneNumber.layer.borderWidth = 2
        phoneNumber.layer.borderColor = UIColor.darkGray.cgColor
        signUp.anchor(top: phoneNumber.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 45, bottom: 0, right: 0),size: .init(width: 300, height: 70))
        signUp.setTitle("Edit", for: .normal)
        signUp.setTitleColor(.white, for: .normal)
        signUp.backgroundColor = .darkGray
        view.backgroundColor = .systemGray6
    }
    //this is used for the send confirmation Email
    fileprivate func createIndex(title: String) -> [String] {
        var searchableIndex = [String]()
        let myLength = title.count
        for index in 1...myLength{
            let myString = String(title.prefix(index))
            searchableIndex.append(myString)
        }
        return searchableIndex
    }
    
    //this show the hud and the error
    fileprivate func showHUDWithError(error: Error) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    //this is a error message
    fileprivate func showWithString(string: String) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed Registration \(string)"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    //this validates all of our fields
    //MARK: this if for field authentication
    fileprivate func validateFieldsFilled() -> String?{
        let a1 = username.text
        let a2 = username.text
        //checks to see if all the fields and image is selected
        if (username.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || booleanImageHit == false){
            if booleanImageHit == false{
                return "Please Select An Image"
            }else{
            return "Not All Fields Filled"
            }
        }
        //checks username length
        if a1?.count ?? 0 < 4{
            return "Username To Short"
        }else if a2?.count ?? 0 > 10{
            return "Username To Long"
        }
        let myEmailisValid =  isValidEmail(email.text ?? "")
        if myEmailisValid == false {
            return "Email Address Not Valid"
        }
        let myPhoneNumber =  isPasswordValid(phoneNumber.text ?? "")
        if myPhoneNumber == false {
            return "Email Not Valid"
        }
        return nil
    }
    //MARK: checks if valid email
    fileprivate func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    //MARK: checks valid email address
    fileprivate func validate() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    fileprivate func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    //this is a method run when sign up is hit
    //MARK: the sign up button is hit
    @objc fileprivate func signUpHit(_ sender: Any) {
        self.delegate?.signUpHit()
    }
    //this is used when to create the image
    @objc fileprivate func ImageHit(){
        self.imagePicker.present(from: self.view)
    }
    //this goes to the back button
    @objc fileprivate func backHit(){
        delegate?.removed()
    }
}


