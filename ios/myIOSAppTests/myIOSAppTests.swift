//
//  myIOSAppTests.swift
//  myIOSAppTests
//
//  Created by Michael  on 3/31/21.
//

import XCTest
@testable import myIOSApp

class myIOSAppTests: XCTestCase {
    
    func test_LoginSignUpPage_labels(){
        let loginSignUpPage = LoginOrSignUpViewController()
        loginSignUpPage.viewDidLoad()
        let textLabel1 = "Food Finder"
        let textLabel2 = "Find the Resturant of Your Dreams!"
        let textLabel3 = "Create Account"
        let textLabel4 = "Login"
        XCTAssertEqual(textLabel1, loginSignUpPage.andOneLabel.text)
        XCTAssertEqual(textLabel2, loginSignUpPage.appDescription.text)
        XCTAssertEqual(textLabel3, loginSignUpPage.CreateAccount.titleLabel?.text)
        XCTAssertEqual(textLabel4, loginSignUpPage.login.titleLabel?.text)
    }
    func test_LoginSignUpPage_image(){
        let loginSignUpPage = LoginOrSignUpViewController()
        loginSignUpPage.viewDidLoad()
        let image = UIImage(imageLiteralResourceName: "ResturantHome")
        XCTAssertEqual(image, image)

    }
    func test_loginPageCreation_label(){
        let loginPage = LoginPageViewController()
        loginPage.viewDidLoad()
        let textLabel1 = "Food Finder"
        let textLabel2 = "Username"
        let textLabel3 = "Password"
        let textLabel4 = "Login"
        XCTAssertEqual(textLabel1,loginPage.andOne.text)
        XCTAssertEqual(textLabel2, loginPage.username.placeholder)
        XCTAssertEqual(textLabel3,loginPage.password.placeholder)
        XCTAssertEqual(textLabel4,loginPage.login.titleLabel?.text)
    }
    func test_loginPageCreation_images(){
        let loginPage = LoginPageViewController()
        loginPage.viewDidLoad()
        let emailPersonImg = UIImage(systemName: "person.circle.fill")
        let passwordLockImg =  UIImage(systemName: "lock")
        let myImage = UIImage(named: "ResturantHome")
        let myImg = UIImage(systemName: "arrow.left")
        XCTAssertEqual(emailPersonImg, loginPage.emailPersonImg)
        XCTAssertEqual(passwordLockImg, loginPage.passwordLockImg)
        XCTAssertEqual(myImage,loginPage.myImage)
        XCTAssertEqual(myImg,loginPage.myImg)
    }
    func test_loginPageCreation_validateFields(){
        let loginPage = LoginPageViewController()
        loginPage.viewDidLoad()
        loginPage.username.text = "Hello"
        loginPage.password.text = ""
        XCTAssertEqual("please Fill in one of the Fileds", loginPage.validateFieldsFilled())
        loginPage.username.text = ""
        loginPage.password.text = "Hello"
        XCTAssertEqual("please Fill in one of the Fileds", loginPage.validateFieldsFilled())
        loginPage.username.text = "botdfadsfh"
        loginPage.password.text = "dfsafdsf"
        XCTAssertEqual(nil, loginPage.validateFieldsFilled())
    }
    func test_loginTapped(){
        let loginPage = LoginPageViewController()
        loginPage.viewDidLoad()
        loginPage.username.text = "Hello"
        loginPage.password.text = ""
        loginPage.loginTapped()
        loginPage.showWithString(string: "" )
    }
    func test_SignUpPageSignUp_textfields(){
        let signUpPage =  SignUpPageSignUp()
        signUpPage.viewDidLoad()
        let imageLabel = "Add an image"
        let username = "Username(4-10 characters unique)"
        let email = "Email"
        let password = "Password"
        let signUp = "Sign Up"
        XCTAssertEqual(imageLabel, signUpPage.selectImageLabel.text)
        XCTAssertEqual(username,signUpPage.username.placeholder)
        XCTAssertEqual(email, signUpPage.email.placeholder)
        XCTAssertEqual(password, signUpPage.phoneNumber.placeholder)
        XCTAssertEqual(signUp, signUpPage.signUp.titleLabel?.text)
  
    }
    func test_SignUpPageSignUp_validateFieldsFilled(){
        let signUpPage =  SignUpPageSignUp()
        signUpPage.viewDidLoad()
        signUpPage.username.text = "myuserName"
        signUpPage.email.text = "test1@email.com"
        signUpPage.booleanImageHit = false
        XCTAssertEqual("Please Select An Image",signUpPage.validateFieldsFilled())
        signUpPage.username.text = "myuserName"
        signUpPage.email.text = ""
        signUpPage.booleanImageHit = true
        XCTAssertEqual("Not All Fields Filled", signUpPage.validateFieldsFilled())
        signUpPage.username.text = "u2"
        signUpPage.email.text = "test1@email.com"
        signUpPage.phoneNumber.text = "radar1818!"
        signUpPage.booleanImageHit = true
        XCTAssertEqual("Username To Short", signUpPage.validateFieldsFilled())
        signUpPage.username.text = "myuser12fdasfdas"
        signUpPage.email.text = "test1@email.com"
        signUpPage.phoneNumber.text = "radar1818!"
        signUpPage.booleanImageHit = true
        XCTAssertEqual("Username To Long", signUpPage.validateFieldsFilled())
        signUpPage.username.text = "myuser12"
        signUpPage.email.text = "test1.com"
        signUpPage.phoneNumber.text = "radar1818!"
        signUpPage.booleanImageHit = true
        XCTAssertEqual("Email Address Not Valid", signUpPage.validateFieldsFilled())
        signUpPage.phoneNumber.text = "radar1818!"
        signUpPage.username.text = "myuser12"
        signUpPage.email.text = "test1.com"
        signUpPage.booleanImageHit = true
        XCTAssertEqual("Email Address Not Valid", signUpPage.validateFieldsFilled())
        signUpPage.username.text = "myuser12"
        signUpPage.email.text = "test1@email.com"
        signUpPage.phoneNumber.text = "radar1818!"
        signUpPage.booleanImageHit = true
        XCTAssertEqual(nil, signUpPage.validateFieldsFilled())
        signUpPage.showWithString(string: "")
        
    }
    func test_SignUpPageSignUp_isPasswordValid(){
            let signUpPage = SignUpPageSignUp()
            signUpPage.viewDidLoad()
            XCTAssertEqual(false, signUpPage.isPasswordValid("@"))
            XCTAssertEqual(false, signUpPage.isPasswordValid("abc123"))
            XCTAssertEqual(false, signUpPage.isPasswordValid("aBc123!"))
            XCTAssertEqual(true, signUpPage.isPasswordValid("abc1234!"))
    }
    func test_SignUpPageSignUp_isValidEmailSucc(){
            let signUpPage = SignUpPageSignUp()
            signUpPage.viewDidLoad()
            XCTAssertEqual(true, signUpPage.isValidEmail("abc@gmail.com"))
            XCTAssertEqual(false, signUpPage.isValidEmail("abcgmail.com"))
            XCTAssertEqual(false, signUpPage.isValidEmail("abc@gmailcom"))
        }
    func test_signUpHit(){
            let signUpPage = SignUpPageSignUp()
            signUpPage.viewDidLoad()
            signUpPage.signUpHit(signUpPage)
        }
    func test_HomePageCreation(){
        let myPage = moreInfoPage()
        let user = User(id: 1, name: "Michael", category: 1, rating: "12", num_ratings: 1, price: 1, latitude: "12.3", longitude: "30.2")
        myPage.user = user
        
        }
    func test_HomePage(){
        let myPage = HomePage()
        myPage.viewDidLoad()
        let user = User(id: 1, name: "Michael", category: 1, rating: "12", num_ratings: 1, price: 1, latitude: "12.3", longitude: "30.2")
        //myPage.user = user
        
        }
    func test_editProfile(){
        let myPage = EditProfile()
        myPage.viewDidLoad()
//        let user = User(id: 1, name: "Michael", category: 1, rating: "12", num_ratings: 1, price: 1, latitude: "12.3", longitude: "30.2")
        //myPage.user = user
        
        }
    func test_editCardView(){
        let myPage = CardView()
        let user = User(id: 1, name: "Michael", category: 1, rating: "12", num_ratings: 1, price: 1, latitude: "12.3", longitude: "30.2")
        myPage.user = user
        
        }
}
