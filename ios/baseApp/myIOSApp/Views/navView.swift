//
//  navView.swift
//  myIOSApp
//
//  Created by Michael  on 5/1/21.
//
//
//  NavigationSocial.swift
//  BasketballAppTwo
//
//  Created by Michael  on 12/31/20.
//
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import UIKit
protocol NavigationSocialDelegate {
    func editProfileHit()
    func reportAScore()
    func logout()
}
class navView: UIView {
    var delegate: NavigationSocialDelegate?
    let profilePic = UIImageView()
    var PicImage = String(){
        didSet{
            profilePic.image = #imageLiteral(resourceName: "Image-2")
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupLayout(){
        let playButtonImage = UIImage(systemName: "gearshape.fill")
        let playButtonImageField = UIImageView()
        let editProfileButton = UIImage(systemName: "slider.horizontal.below.square.fill.and.square")
        let editProfileButtonField = UIButton()
        let editProfile = UIButton(type: .system)
        let playButton = UIButton(type: .system)
        let aboutAndOne = UIButton(type: .system)
        let information = UIImage(systemName: "info.circle.fill")
        let informationView = UIButton(type: .system)
        let bottomDivider = UIView()
        addSubview(profilePic)
        addSubview(editProfile)
        addSubview(playButton)
        addSubview(aboutAndOne)
        addSubview(informationView)
        addSubview(informationView)
        addSubview(editProfileButtonField)
        addSubview(bottomDivider)
        editProfile.addSubview(playButtonImageField)
        playButtonImage?.withTintColor(.gray)
        playButtonImageField.tintColor = .white
        playButtonImageField.image = playButtonImage
        editProfileButtonField.setImage(editProfileButton, for: .normal)
        editProfile.titleLabel?.textColor = .white
        editProfile.titleLabel?.tintColor = .white
        editProfile.addTarget(self, action: #selector(editProfileHit), for: .touchUpInside)
        aboutAndOne.addTarget(self, action: #selector(abAndOne), for: .touchUpInside)
        informationView.addTarget(self, action: #selector(infoButtonHit), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(ReportAScore), for: .touchUpInside)
        editProfileButtonField.addTarget(self, action: #selector(ReportAScore), for: .touchUpInside)
        profilePic.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 15, bottom: 0, right: 0),size: .init(width: 50, height: 50))
        profilePic.layer.cornerRadius = 25
        profilePic.clipsToBounds = true
        profilePic.image?.withRenderingMode(.alwaysOriginal)
        profilePic.contentMode = .scaleAspectFill
        profilePic.backgroundColor = .gray
        backgroundColor = .white
        editProfile.anchor(top: topAnchor, leading: profilePic.trailingAnchor, bottom: nil, trailing: nil , padding: .init(top: 38, left: 10, bottom: 0, right: 0),size: .init(width: 150, height: 30))
        editProfile.setTitle("Edit Profile", for: .normal)
        editProfile.backgroundColor = .systemGray
        //editProfile.setTitleColor(.darkGray, for: .normal)
        editProfile.layer.cornerRadius = 7
        playButtonImageField.anchor(top: editProfile.topAnchor, leading: editProfile.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: -24, bottom: 0, right: 0),size: .init(width: 15, height: 15))
        aboutAndOne.setTitle("Logout", for: .normal)
        aboutAndOne.tintColor = .black
        aboutAndOne.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 24, left: 0, bottom: 0, right: 34))
        informationView.tintColor = .black
        informationView.setImage(information, for: .normal)
        informationView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 28, left: 0, bottom: 0, right: 10), size: .init(width: 20, height: 20))
        playButton.anchor(top: aboutAndOne.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 36))
        playButton.setTitle("Recent Likes", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        editProfileButtonField.tintColor = .gray
        editProfileButtonField.anchor(top: playButton.topAnchor, leading: playButton.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 5, left: 3, bottom: 0, right: 0))
        bottomDivider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        bottomDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider.backgroundColor = .systemGray6
    }
    @objc fileprivate func editProfileHit(){
        delegate?.editProfileHit()
    }
    @objc fileprivate func infoButtonHit(){
     
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "username=ford&password=root3dd"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://csds393.herokuapp.com/api/logout/")!,timeoutInterval: Double.infinity)
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
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    self.delegate?.logout()
    }
    @objc fileprivate func ReportAScore(){
        delegate?.reportAScore()
    }
    @objc fileprivate func abAndOne(){
        var semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://csds393.herokuapp.com/api/logout/")!,timeoutInterval: Double.infinity)

        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(response)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        self.delegate?.logout()
    }
}

