import UIKit
protocol CardViewDelegate {
    func nextCard(translation: Int)
    func infoHit()
}
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
    var user: User? {
       didSet{
        layer.cornerRadius = 10
        backgroundColor = .blue
        clipsToBounds = true
        let myImage2 = UIImage(named: user?.Image ?? "")?.withRenderingMode(.alwaysOriginal)
        let backgroundImg = UIImageView(image: myImage2)
        backgroundImg.image?.withRenderingMode(.alwaysOriginal)
        backgroundImg.contentMode = .scaleAspectFill
        addSubview(backgroundImg)
        backgroundImg.fillSuperview()
        let ResturantTypeLabel = UILabel()
        let priceLabel = UILabel()
        addSubview(priceLabel)
        priceLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 9, right: 0))
        priceLabel.textColor = .white
        priceLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.numberOfLines = 0
        //\(String(user?.Price ?? 0)
        priceLabel.text = "\(user?.Name ?? "")  \n $$$"
        addSubview(ResturantTypeLabel)
        ResturantTypeLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 20, bottom: 20, right: 0))
        ResturantTypeLabel.text = "\(user?.ResturantType ?? "")"
        ResturantTypeLabel.textColor = .white
        ResturantTypeLabel.font = .boldSystemFont(ofSize: 25)
        image2 = UILabel()
        image2?.backgroundColor = .systemGreen
        image2?.alpha = 0
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
        image3?.text = "DISLIKE"
        image3?.textColor = .white
        setupGradientLayer()
        addSubview(moreInfoButton)
        moreInfoButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 20) ,size: .init(width: 40, height: 40))
       }
    }
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupLayout()
           let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
           addGestureRecognizer(panGesture)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > 80
        if shouldDismissCard{
            if translationDirection == 1 {
                self.delegate?.nextCard(translation: 700)
            }else{
                self.delegate?.nextCard(translation: -700)
            }
        }else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.image2?.alpha = 0
                self.image3?.alpha = 0
                self.transform = .identity
            })
        }
    }
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
