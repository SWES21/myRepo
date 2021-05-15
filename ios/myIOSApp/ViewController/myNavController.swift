//
//  myNavController.swift
//  myIOSApp
//
//  Created by Michael  on 4/1/21.
//

import UIKit

class myNavController: UINavigationController, firstPageProtocol, LoginPageViewControllerProt, signedUp, LogoutPage{
    func leave() {
        //this puts the processes
        DispatchQueue.main.async {
            let controller = LoginOrSignUpViewController()
            controller.delegate = self
            self.pushViewController(controller, animated: true)
        }
    }
    //this pops the top controller
    func removed() {
    popViewController(animated: true)
    }
    //the sign up is hit and it pushes the controller form the main page
    func signUpHit() {
        DispatchQueue.main.async {
    let controller = HomePage()
    controller.delegate = self
    self.pushViewController(controller, animated: true)
        }
    }
    //this is the back controller that pops the main controller from the top
    func backHit() {
    popViewController(animated: true)
    }
    //The login was hit in order to pop the home page
    func loginHit() {
    let controller = HomePage()
    controller.delegate = self
    pushViewController(controller, animated: true)
    }
    //this creates the sign up page and creates a delegate that is clicked when teh sign up button is hit
    func myAccount() {
        let messageView = SignUpPageSignUp()
        messageView.delegate = self
        messageView.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        popViewController(animated: true)
        pushViewController(messageView, animated: false)
    }
    //this is the login page in order to create the view controller
    func login1() {
        let messageView = LoginPageViewController()
        messageView.delegate = self
        messageView.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        popViewController(animated: true)
        pushViewController(messageView, animated: false)
    }
    
    //the view did 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
