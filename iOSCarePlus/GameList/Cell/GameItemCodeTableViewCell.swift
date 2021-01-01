//
//  GameItemCodeTableViewCell.swift
//  iOSCarePlus
//
//  Created by 이문정 on 2020/12/24.
//

import UIKit

class GameItemCodeTableViewCell: UITableViewCell {
    var gameImageView: UIImageView
    var titelLabel: UILabel
    var priceLabel: UILabel
    
    // 뷰를 만들고 contentView(상위뷰)에 얹어줌
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        gameImageView = UIImageView()
        titelLabel = UILabel()
        priceLabel = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(gameImageView)
        contentView.addSubview(titelLabel)
        contentView.addSubview(priceLabel)
        
        // 오토레이아웃 잡기
        // (자동제약조건) 코드로 작업시 무조건 false로 잡아줌
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        titelLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //NSLayoutConstraint.activate를 이용해서 제약조건들을 배열로 넣어준다.
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            gameImageView.widthAnchor.constraint(equalToConstant: 122),
            gameImageView.heightAnchor.constraint(equalToConstant: 69)
        ])
        
        gameImageView.backgroundColor = .green
        
        NSLayoutConstraint.activate([
        titelLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 10),
        titelLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 12),
        titelLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 15)
        ])
        
        titelLabel.text = "test"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
