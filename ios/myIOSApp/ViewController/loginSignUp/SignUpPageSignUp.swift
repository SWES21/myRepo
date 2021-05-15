//
//  SignUpPageSignUp.swift
//  Created by Michael  on 1/6/21.
//

import UIKit
import JGProgressHUD
import CoreLocation
import LBTATools
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
//this is used in order
protocol signedUp {
    func removed()
    func signUpHit()
}
//This is used in to create a custom instance of the view controller which uses the location delegate
class SignUpPageSignUp: UIViewController, CLLocationManagerDelegate {
    let url = URL(string: APPURL.Url)
    var nsCache = NSCache<NSString, UIImage>()
    let myImage = UIButton()
    var delegate: signedUp?
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
    //this loads the views for the sign up page
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        setupLayout()
    }
    //this sets up the Layout in order to create the views 
    func setupLayout() {
        view.backgroundColor = .white
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        //thse are the fields
        let screenSize = UIScreen.main.bounds
        let ScreenWidth = screenSize.width
        let myImg = UIImage(systemName: "arrow.left")
        let backArrow = UIButton()
        let SelectDateLabel = UITextField()
        //create subviews
        view.addSubview(myImage)
        view.addSubview(SelectDateLabel)
        view.addSubview(username)
        view.addSubview(email)
        view.addSubview(phoneNumber)
        view.addSubview(backArrow)
        myImage.addSubview(selectImageLabel)
        view.addSubview(signUp)
        //targets
        myImage.addTarget(self, action: #selector(ImageHit), for: .touchUpInside)
        signUp.addTarget(self, action: #selector(signUpHit), for: .touchUpInside)
        backArrow.addTarget(self, action: #selector(backHit), for: .touchUpInside)
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
        signUp.setTitle("Sign Up", for: .normal)
        signUp.setTitleColor(.white, for: .normal)
        signUp.backgroundColor = .darkGray
        view.backgroundColor = .systemGray6
        backArrow.setImage(myImg, for: .normal)
        backArrow.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 15, bottom: 0, right: 0),size: .init(width: 20, height: 20))
    }
    //this show the hud and the error
    func showWithString(string: String) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed Registration \(string)"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    //this validates all of our fields
    //MARK: this if for field authentication
    func validateFieldsFilled() -> String?{
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
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    //this is a method run when sign up is hit
    //MARK: the sign up button is hit
    @objc func signUpHit(_ sender: Any) {
        let error = validateFieldsFilled()
        let email1 = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let username1 = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password1 = phoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if error == nil {
            let semaphore = DispatchSemaphore (value: 0)
            let parameters = "username=\(username1)&password=\(password1)&email=\(email1)"
            let postData =  parameters.data(using: .utf8)
            var request = URLRequest(url: URL(string: "https://csds393.herokuapp.com/api/signup/")!,timeoutInterval: Double.infinity)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("csrftoken=8mR03hOgdQid1Iv5HSHO7TjoTc3LpYmuGGcNuVVVGHxbZvVimlVV4ZsnBnrI0KxF", forHTTPHeaderField: "Cookie")

            request.httpMethod = "POST"
            request.httpBody = postData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
              }
              print(String(data: data, encoding: .utf8)!)
                let httpResponse = response as? HTTPURLResponse
                  if (httpResponse?.statusCode ?? 0 == 200){
                      DispatchQueue.main.async {
                        self.delegate?.signUpHit()
                      }
                  }else{
                    self.showWithString(string: "Usernmae Taken")
                }
              semaphore.signal()
            }
            task.resume()
            semaphore.wait()

        }else{
            DispatchQueue.main.async {
             self.showWithString(string: error ?? "")
            }
        }
    }
    //this is used when to create the image
    @objc func ImageHit(){
        self.imagePicker.present(from: self.view)
    }
    //this goes to the back button
    @objc func backHit(){
        delegate?.removed()
    }
}

//this is used for the camera
extension SignUpPageSignUp: ImagePickerDelegate {
     func didSelect(image: UIImage?) {
        self.myImage.setImage(image, for: .normal)
        APPURL.imageHead = image ?? #imageLiteral(resourceName: "Image-2")
        myImage.layer.borderWidth = 0
        selectImageLabel.removeFromSuperview()
        booleanImageHit = true
    }
}


