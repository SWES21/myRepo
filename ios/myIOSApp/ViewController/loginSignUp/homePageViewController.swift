import UIKit
import JGProgressHUD
import CoreLocation
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
protocol LogoutPage {
    func leave()
}
class HomePage: UIViewController, CardViewDelegate, NavigationSocialDelegate, CLLocationManagerDelegate{
    func logout() {
        delegate?.leave()
    }
    //create editprofile view
    func editProfileHit() {
        let myView = EditProfile()
        myView.view.backgroundColor = .white
        present(myView, animated: true, completion: nil)
    }
    //create RecentlyLikedPages view
    func reportAScore() {
        let myView = RecentlyLikedPages()
        present(myView, animated: true, completion: nil)
    }
    //create more info page view
    func infoHit() {
        let myView = moreInfoPage()
        myView.user = cardDeckHead?.user
        myView.view.backgroundColor = .white
        present(myView, animated: true, completion: nil)
    }
    func nextCard(translation: Int, resturantId: Int) {
        let duration = 0.5
        let translationAnimation = CABasicAnimation(keyPath: "position.x")
        translationAnimation.toValue = translation
        translationAnimation.duration = duration
        translationAnimation.fillMode = .forwards
        translationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        translationAnimation.isRemovedOnCompletion = false
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = 15 * CGFloat.pi / 180
        rotationAnimation.duration = duration
        
        CATransaction.setCompletionBlock { [self] in
        if cardDeckHead?.nextCard == nil {
            self.myInitialViewQueryTwo()
        }
        if translation > 0{
            
        APPURL.UserModel.append(cardDeckHead?.user ?? User(id: 0, name: "", category: 0, rating: "", num_ratings: 0, price: 0, latitude: "", longitude: ""))
        }
        self.cardDeckHead?.removeFromSuperview()
        self.cardDeckHead = self.cardDeckHead?.nextCard
        self.cardDeckHead?.delegate = self
        self.myView.addSubview(self.cardDeckHead?.nextCard ?? self.dummycard)
        self.myView.sendSubviewToBack(self.cardDeckHead?.nextCard ?? self.dummycard)
        self.cardDeckHead?.nextCard?.fillSuperview()
        
        let translationDirection: CGFloat = translation > 0 ? 1 : -1
            if translationDirection == 1{
            let semaphore = DispatchSemaphore (value: 0)

            let parameters = "restaurant_id=\(resturantId)"
            let postData =  parameters.data(using: .utf8)

            var request = URLRequest(url: URL(string: "https://csds393.herokuapp.com/api/user/recommendations/update/liked")!,timeoutInterval: Double.infinity)
            request.httpMethod = "POST"
            request.httpBody = postData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard data != nil else {
                semaphore.signal()
                return
              }
              semaphore.signal()
            }
            task.resume()
            semaphore.wait()
            }else{
                let semaphore = DispatchSemaphore (value: 0)
            let parameters = "restaurant_id=\(resturantId)"
            let postData =  parameters.data(using: .utf8)

            var request = URLRequest(url: URL(string: "https://csds393.herokuapp.com/api/user/recommendations/update/disliked")!,timeoutInterval: Double.infinity)
            request.httpMethod = "POST"
            request.httpBody = postData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard data != nil else {
                semaphore.signal()
                return
              }
              semaphore.signal()
            }

            task.resume()
            semaphore.wait()
            }

        }
        cardDeckHead?.layer.add(translationAnimation, forKey: "translation")
        cardDeckHead?.layer.add(rotationAnimation, forKey: "rotation")
        CATransaction.commit()
    }
    
    //This is used for nill coelesing
      var count = 0
      let fillerUIView = UIView()
      let dummycard = CardView()
      fileprivate lazy var screenSize = UIScreen.main.bounds
      fileprivate lazy var ScreenWidth = ((screenSize.width)+20)
      let searchBarView = navView()
      fileprivate var myView = UIView()
      var myUser:User?
      var lastAddedPointer: CardView?
      var cardDeckHead: CardView?
      var users = [User]()
      var cardDeckView = [CardView]()
      var nextCardInstantiation: CardView?
      var lon: Double?
      var lat: Double?
      var delegate:LogoutPage?
      var locationManager = CLLocationManager()

    override func viewDidLoad() {
           super.viewDidLoad()
        for _ in 0..<10 {
                let myCard = CardView()
                self.cardDeckView.append(myCard)
            }
           setUpLayout()
           myInitialViewQuery()
           searchBarView.delegate = self
           self.locationManager.requestAlwaysAuthorization()

          // For use in foreground
          self.locationManager.requestWhenInUseAuthorization()

          if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
       }
    }
     func myInitialViewQuery(){
        let semaphore = DispatchSemaphore (value: 0)
        let parameters = ""
        let postData =  parameters.data(using: .utf8)
        let url =  URL(string: "https://csds393.herokuapp.com/api/user/recommendations/get")
        var request = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.httpBody = postData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            semaphore.signal()
            return
          }
            semaphore.signal()
            do {
                let users = try JSONDecoder().decode(Recommendations.self, from: data)
                users.recommendations.forEach { (user) in
                    self.cardDeckView[self.count].user = user
                    self.addUser(CardView: self.cardDeckView[self.count])
                    self.count = self.count + 1
                }
                DispatchQueue.main.async {
                self.firstCardCreated()
                }
        }catch let jsonErr {
            print("Error serializing json:", jsonErr)
        }
        }
        task.resume()
        semaphore.wait()
    }
    func myInitialViewQueryTwo(){
        for _ in 0..<10 {
                let myCard = CardView()
                self.cardDeckView.append(myCard)
        }
       let semaphore = DispatchSemaphore (value: 0)
       let parameters = ""
       let postData =  parameters.data(using: .utf8)
       let url =  URL(string: "https://csds393.herokuapp.com/api/user/recommendations/get")
       var request = URLRequest(url:url!)
       request.httpMethod = "GET"
       request.httpBody = postData
       let task = URLSession.shared.dataTask(with: request) { data, response, error in
         guard let data = data else {
           semaphore.signal()
           return
         }
           semaphore.signal()
           do {
               let users = try JSONDecoder().decode(Recommendations.self, from: data)
             self.cardDeckHead = self.cardDeckView[self.count]
               users.recommendations.forEach { (user) in
                self.cardDeckView[self.count].user = user
                self.addUser(CardView: self.cardDeckView[self.count])
                self.count = self.count + 1
               }
               DispatchQueue.main.async {
               self.firstCardCreated()
               }
       }catch let jsonErr {
           print("Error serializing json:", jsonErr)
       }
       }
       task.resume()
       semaphore.wait()
   }
    fileprivate func addUser(CardView : CardView){
        let myNewNode = CardView
         if cardDeckHead == nil{
             cardDeckHead = myNewNode
             lastAddedPointer = myNewNode
             lastAddedPointer?.nextCard = nil
         }else{
             lastAddedPointer?.nextCard = myNewNode
             lastAddedPointer = myNewNode
             lastAddedPointer?.nextCard = nil
         }
     }
    
    fileprivate func firstCardCreated(){
         self.myView.addSubview(self.cardDeckHead ?? self.fillerUIView)
         self.myView.sendSubviewToBack(self.cardDeckHead ?? self.fillerUIView)
         self.myView.addSubview(self.cardDeckHead?.nextCard ?? self.dummycard)
         self.myView.sendSubviewToBack(self.cardDeckHead?.nextCard ?? self.dummycard)
         self.cardDeckHead?.fillSuperview()
         cardDeckHead?.delegate = self
         self.cardDeckHead?.nextCard?.fillSuperview()
     }

    func setUpLayout() {
           view.backgroundColor = .white
           let overallStackView = UIStackView(arrangedSubviews: [myView])
           view.addSubview(overallStackView)
           view.addSubview(searchBarView)
           overallStackView.axis = .vertical
           overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
           overallStackView.isLayoutMarginsRelativeArrangement = true
           overallStackView.layoutMargins = .init(top: 85, left: 13, bottom: 15, right: 13)
           overallStackView.bringSubviewToFront(myView)
           searchBarView.anchor(top: view.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
           searchBarView.PicImage = ""
           searchBarView.heightAnchor.constraint(equalToConstant: 90).isActive = true
           }
}
