//
//  myNavController.swift
//  myIOSApp
//
//  Created by Michael  on 4/1/21.
//

import UIKit

class myNavController: UINavigationController, firstPageProtocol, LoginPageViewControllerProt, signedUp, LogoutPage{
    func leave() {
        DispatchQueue.main.async {
            let controller = LoginOrSignUpViewController()
            controller.delegate = self
            self.pushViewController(controller, animated: true)
        }
    }
    
    func removed() {
    popViewController(animated: true)
    }
    
    func signUpHit() {
    let controller = HomePage()
    controller.delegate = self
    pushViewController(controller, animated: true)
    }
    
    func backHit() {
    popViewController(animated: true)
    }
    
    func loginHit() {
    let controller = HomePage()
    controller.delegate = self

    pushViewController(controller, animated: true)
    }
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
