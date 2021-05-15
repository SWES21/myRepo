import UIKit
//This is used in order to hit the nextCard
//This is used in order to hit the
//:MARK
protocol CardViewDelegate {
    func nextCard(translation: Int, resturantId:Int)
    func infoHit()
}
//this is used to formate strings
extension String {
     func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
}
//This creates the view for the card views
class CardView: UIView {
    fileprivate let gradientLayer = CAGradientLayer()
    var nextCard: CardView?
    var resturantID: String?
    var Name: String?
    var Price: Int?
    var Date: NSDate?
    var Image: UIImage?
    var lon: Double?
    var lat: Double?
    var imgView3: UIImageView?
    var image2:UILabel?
    var image3:UILabel?
    var delegate: CardViewDelegate?
    //This card was used in order to create the card when the user in order to create the user
    var user: User? {
       didSet{
        let ResturantTypeLabel = UILabel()
        addSubview(ResturantTypeLabel)
        ResturantTypeLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 20, bottom: 20, right: 0))
        layer.cornerRadius = 10
        backgroundColor = .blue
        clipsToBounds = true
        let priceLabel = UILabel()
        addSubview(priceLabel)
        priceLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 9, right: 0))
        priceLabel.textColor = .white
        priceLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.numberOfLines = 0
        //\(String(user?.Price ?? 0)
        ResturantTypeLabel.textColor = .white
        ResturantTypeLabel.font = .boldSystemFont(ofSize: 25)
        //price is used in order to
        let priceType = user?.price
        switch priceType {
        case 0:
            //the different prices are shown with $ based on the UI
            priceLabel.text = "\(user?.name ?? "FillerRes")  \n $"
        case 1:
            priceLabel.text = "\(user?.name ?? "FillerRes")  \n $$"
        case 2:
            priceLabel.text = "\(user?.name ?? "FillerRes")  \n $$$"
        default:
            priceLabel.text = "\(user?.name ?? "FillerRes")  \n $"
        }
        let resturantCat = user?.category ?? 0
        //The differnt types of resturants are shown below based on the category
        switch resturantCat {
        case 0:
            ResturantTypeLabel.text = "America"
        case 1:
            ResturantTypeLabel.text = "French"
        case 2:
            ResturantTypeLabel.text = "Cafe"
        case 3:
            ResturantTypeLabel.text = "Southern"
        case 4:
            ResturantTypeLabel.text = "Italian"
        case 5:
            ResturantTypeLabel.text = "Mexican"
        case 6:
            ResturantTypeLabel.text = "BBQ"
        case 7:
            ResturantTypeLabel.text = "Ice Cream"
        case 8:
            ResturantTypeLabel.text = "Vietnamese"
        case 9:
            ResturantTypeLabel.text = "Chinese"
        case 10:
            ResturantTypeLabel.text = "Mediterranean"
        case 11:
            ResturantTypeLabel.text = "Cajun"
        case 12:
            ResturantTypeLabel.text = "Japanese"
        case 13:
            ResturantTypeLabel.text = "Seafood"
        case 14:
            ResturantTypeLabel.text = "Thai"
        case 15:
            ResturantTypeLabel.text = "Caribbean"
        case 16:
            ResturantTypeLabel.text = "Korean"
        case 17:
            ResturantTypeLabel.text = "Szechaun"
        case 18:
            ResturantTypeLabel.text = "Indian"
        case 19:
            ResturantTypeLabel.text = "Brazilian"
        case 20:
            ResturantTypeLabel.text = "Latin American"
        default:
            ResturantTypeLabel.text = "American"
        }
        //images like and dislike
        image2 = UILabel()
        image2?.backgroundColor = .systemGreen
        image2?.alpha = 0
        //The like image is shown fading in it is placed in the view below
        image2?.text = "LIKE"
        image2?.textColor = .white
        addSubview(image2 ?? UILabel())
        image2?.font = .boldSystemFont(ofSize: 20)
        image2?.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing:nil, padding: .init(top: 200, left: 80, bottom: 0, right: 0), size: .init(width: 200, height: 120))
        image2?.textAlignment = .center
        image2?.layer.cornerRadius = 12
        image2?.clipsToBounds = true
        image3 = UILabel()
        addSubview(image3 ?? UILabel())
        image3?.font = .boldSystemFont(ofSize: 20)
        image3?.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing:nil, padding: .init(top: 200, left: 80, bottom: 0, right: 0), size: .init(width: 200, height: 120))
        image3?.textAlignment = .center
        image3?.layer.cornerRadius = 12
        image3?.clipsToBounds = true
        image3?.backgroundColor = .systemRed
        image3?.alpha = 0
        //The are dislike is added also below
        image3?.text = "DISLIKE"
        image3?.textColor = .white
        setupGradientLayer()
        addSubview(moreInfoButton)
        moreInfoButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 20) ,size: .init(width: 40, height: 40))
        DispatchQueue.main.async {
        //The image is used in
        let myImage2 = UIImage(named: "type" + " \(self.user?.category ?? 0)")?.withRenderingMode(.alwaysOriginal)
        let backgroundImg = UIImageView(image: myImage2)
        backgroundImg.image?.withRenderingMode(.alwaysOriginal)
        backgroundImg.contentMode = .scaleAspectFill
        self.addSubview(backgroundImg)
        //this fills the superview of the background image
        backgroundImg.fillSuperview()
            self.sendSubviewToBack(backgroundImg)
        }
        }
    }
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           //this sets up the layout of the images in a row
           setupLayout()
           //the pan gesture is used in order
           let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
           addGestureRecognizer(panGesture)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //The more info 
    fileprivate let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "moreInfo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleMoreInfo), for: .touchUpInside)
        return button
    }()
    @objc fileprivate func handleMoreInfo(){
    self.delegate?.infoHit()
    }
    func setupLayout(){
        
    }
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .began:
            //
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture: gesture)
        default:
            ()
        }
    }
    fileprivate func setupGradientLayer() {
        // how we can draw a gradient with Swift
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        // self.frame is actually zero frame
        
        layer.addSublayer(gradientLayer)
    }
    override func layoutSubviews() {
        // in here you know what you CardView frame will be
        gradientLayer.frame = self.frame
    }
    //thei is used in when the card is over a threshold it starts teh ended animation
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        //this a statement aht returns a 0 1 or -1 once the transition is completed
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        //this is sued in order to check if the variable is over teh threshowld
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > 80
        if shouldDismissCard{
            //this is used to move the card and calls the next card method in the view controoler
            if translationDirection == 1 {
                self.delegate?.nextCard(translation: 2000, resturantId: user?.id ?? 0)
            }else{
                //this does the same but dismisses based on a dislike
                self.delegate?.nextCard(translation: -2000, resturantId: user?.id ?? 0)
            }
        }else {
            //This is called if the view is not far enough from the center
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.image2?.alpha = 0
                self.image3?.alpha = 0
                self.transform = .identity
            })
        }
    }
    //this is used to cerate the animation as the card is being changed. It also makes the image fade in as you go 
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        image2?.isOpaque = false
        let translation = gesture.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
        image2?.alpha = translation.x * 0.01
        image3?.alpha = translation.x * -0.01
        }
}
