import UIKit
import JGProgressHUD
import CoreLocation
class HomePage: UIViewController, CardViewDelegate {
    func infoHit() {
        let myView = moreInfoPage()
        myView.view.backgroundColor = .white
        present(myView, animated: true, completion: nil)
    }
    func nextCard(translation: Int) {
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
        self.cardDeckHead?.removeFromSuperview()
        self.cardDeckHead = self.cardDeckHead?.nextCard
        self.cardDeckHead?.delegate = self
        self.myView.addSubview(self.cardDeckHead?.nextCard ?? self.dummycard)
        self.myView.sendSubviewToBack(self.cardDeckHead?.nextCard ?? self.dummycard)
        self.cardDeckHead?.nextCard?.fillSuperview()

        }
        cardDeckHead?.layer.add(translationAnimation, forKey: "translation")
        cardDeckHead?.layer.add(rotationAnimation, forKey: "rotation")
        CATransaction.commit()
    }
    
    //This is used for nill coelesing
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
      var cardDeckView = [CardView(),CardView(),CardView(), CardView()]
      var nextCardInstantiation: CardView?
      var lon: Double?
      var lat: Double?

    override func viewDidLoad() {
           super.viewDidLoad()
           setUpLayout()
           myInitialViewQuery()
       }
    fileprivate func myInitialViewQuery(){
        cardDeckView.forEach { (cardView) in
            let usr = User(dictionary: ["resturantID":"someId", "Name": "MexicanResturant", "ResturantType": "Mexican", "Price": 200, "Date": Date(), "Image": "Image", "lon": 12.5, "lat": 14.3])
            cardView.user = usr
            self.addUser(CardView: cardView)
        }
        firstCardCreated()
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

    fileprivate func setUpLayout() {
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
