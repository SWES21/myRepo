//
//  LoginPageViewController.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/6/21.
//

import UIKit
import JGProgressHUD
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
protocol LoginPageViewControllerProt {
    func backHit()
    func loginHit()
}
class LoginPageViewController: UIViewController {
    let myStackView = UIStackView()
    let andOne = UILabel()
    let username = UITextField()
    let password = UITextField()
    let emailImage = UIImageView()
    let passwordImage = UIImageView()
    let login = UIButton(type: .system)
    let myImage2 = UIImageView()
    let forgotPassworld = UIButton(type: .system)
    let registeringHUD = JGProgressHUD(style: .dark)
    var delegate: LoginPageViewControllerProt?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    //this is used to setup the view
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        let screenSize = UIScreen.main.bounds
        let ScreenWidth = screenSize.width
        let emailPersonImg = UIImage(systemName: "person.circle.fill")
        let passwordLockImg = UIImage(systemName: "lock")
        let myImage = UIImage(named: "ResturantHome")
        let myImg = UIImage(systemName: "arrow.left")
        let backArrow = UIButton()
        //adds subviews
        view.addSubview(andOne)
        view.addSubview(myImage2)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(forgotPassworld)
        view.addSubview(login)
        view.addSubview(backArrow)
        //creates the targets for buttons
        login.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        backArrow.setImage(myImg, for: .normal)
        backArrow.addTarget(self, action: #selector(backHit), for: .touchUpInside)
        username.autocapitalizationType = .none
        password.autocapitalizationType = .none
        forgotPassworld.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        //setting up of views below
        password.isSecureTextEntry = true
        emailImage.image = emailPersonImg
        passwordImage.image = passwordLockImg
        andOne.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 50, left: ScreenWidth/2.5, bottom: 0, right: 0))
        andOne.text = "serveMe"
        andOne.font = .italicSystemFont(ofSize: 16)
        andOne.textColor = .lightGray
        myImage2.image = myImage
        myImage2.anchor(top: andOne.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: ScreenWidth/2.9, bottom: 0, right: 0), size: .init(width: 100, height: 100))
        username.anchor(top: myImage2.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 25, left: 25, bottom: 0, right: 25))
        username.heightAnchor.constraint(equalToConstant: 35).isActive = true
        username.placeholder = "Username"
        username.layer.cornerRadius = 6
        username.layer.borderWidth = 2
        username.layer.borderColor = UIColor.darkGray.cgColor
        password.anchor(top: username.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 20, left: 25, bottom: 0, right: 25))
        password.heightAnchor.constraint(equalToConstant: 35).isActive = true
        password.placeholder = "Password"
        password.layer.cornerRadius = 6
        password.layer.borderWidth = 2
        password.layer.borderColor = UIColor.darkGray.cgColor
        username.addSubview(emailImage)
        username.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: username.frame.height))
        username.leftViewMode = .always
        emailImage.anchor(top: username.topAnchor, leading: nil, bottom: username.bottomAnchor, trailing: username.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 2, right: 2))
        emailImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        emailImage.tintColor = .black
        password.addSubview(passwordImage)
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: password.frame.height))
        password.leftViewMode = .always
        passwordImage.anchor(top: password.topAnchor, leading: nil, bottom: password.bottomAnchor, trailing: password.trailingAnchor,padding: .init(top: 2, left: 0, bottom: 2, right: 2))
        passwordImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        passwordImage.tintColor = .black
        forgotPassworld.anchor(top: password.bottomAnchor, leading: password.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 100, bottom: 10, right: 0))
        forgotPassworld.setTitle("Forgot Password", for: .normal)
        forgotPassworld.setTitleColor(.systemGray, for: .normal)
        login.anchor(top: forgotPassworld.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: 45, bottom: 0, right: 0),size: .init(width: 300, height: 70))
        login.setTitle("Login", for: .normal)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = .darkGray
        view.backgroundColor = .white
        backArrow.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 15, bottom: 0, right: 0),size: .init(width: 20, height: 20))
        view.sendSubviewToBack(password)
        view.sendSubviewToBack(username)
        view.addSubview(forgotPassworld)
    }
    
    //this creates my hud
    fileprivate func showHUDWithError(error: Error) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3)
    }
    
    //this is a error message
    fileprivate func showWithString(string: String) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed Registration \(string)"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    func validateFieldsFilled() -> String?{
        if (username.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ){
            return "please Fill in one of the Fileds"
        }
        else{return nil}
    }
    //goes to the back hit
    @objc fileprivate func backHit(){
        delegate?.backHit()
    }
    let url = URL(string: APPURL.Url + "/api/login/")
    //this method us used for hitting the login is hit to make sure the login is correct
    @objc func loginTapped() {
        let myFieldsFilled = validateFieldsFilled()
        let username1 = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pswrd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(myFieldsFilled == nil){
        let semaphore = DispatchSemaphore (value: 0)
        let parameters = "username=\(username1)&password=\(pswrd)"
        let postData =  parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://csds393.herokuapp.com/api/login/")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            semaphore.signal()
            return
          }
          let httpResponse = response as? HTTPURLResponse
            if (httpResponse?.statusCode ?? 0 == 200){
                DispatchQueue.main.async {
                self.delegate?.loginHit()
                }
            }else{
                DispatchQueue.main.async {
                self.showWithString(string: "Invalid Login Credentails")
                }
            }
          semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        }else{
            showWithString(string: myFieldsFilled ?? "")
        }
        }
    @objc func resetPassword(){
//        let myPswrd = PasswordReset()
//        present(myPswrd, animated: true, completion: nil)
    }
    
}
