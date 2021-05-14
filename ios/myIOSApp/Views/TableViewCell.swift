//
//  TableViewCell.swift
//  myIOSApp
//
//  Created by Michael  on 5/5/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    let myImg4 = UIImage(systemName: "checkmark.square.fill")
    let myImg5 = UIImage(systemName: "squareshape")
    let pointingImage = UIImageView()
    let myLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    var count = 0 {
        didSet{
            if(count % 2 == 0){
                pointingImage.image = myImg5
            }else{
                pointingImage.image = myImg4
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout(){
    addSubview(myLabel)
    myLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 20, bottom: 0, right: 0))
    myLabel.textColor = .systemGray2
    myLabel.backgroundColor = .white
    myLabel.font = .systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 10))
    myLabel.backgroundColor = .white
    addSubview(pointingImage)
    pointingImage.image = myImg4
    pointingImage.tintColor = .black
    pointingImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 10, bottom: 0, right: 8), size: .init(width: 30, height: 30))
    
    }
}
