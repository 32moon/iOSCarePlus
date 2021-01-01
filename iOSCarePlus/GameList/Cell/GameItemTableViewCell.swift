//
//  GameItemTableViewCell.swift
//  iOSCarePlus
//
//  Created by 이문정 on 2020/12/17.
//

import Kingfisher
import UIKit

class GameItemTableViewCell: UITableViewCell {
    // GameItemModel 클래스에 변수가 직접 접근하는 것을 막기 위해 Private을 사용
    private var model: GameItemModel? {
        didSet {
            setUIFromModel()
        }
    }
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameTitleLabel: UILabel!
    @IBOutlet private weak var gameOriginPrice: UILabel!
    @IBOutlet private weak var gameCurrentPrice: UILabel!
    
    // 모델 세팅
    func setModel(_ model: GameItemModel) {
        self.model = model
    }
    
    // 레이블 세팅
    // model은 옵셔널이기 때문에 guard let옵셔널 바인딩을 해준다.
    func setUIFromModel() {
        guard let model = model else { return }
        
        let imageURL = URL(string: model.imageURL)
        gameImageView.kf.setImage(with: imageURL)
        
        gameImageView.layer.cornerRadius = 9
        gameImageView.layer.borderWidth = 1
        gameImageView.layer.borderColor = UIColor(red: 236 / 255.0, green: 236 / 255.0, blue: 236 / 255.0, alpha: 0).cgColor
        
        gameTitleLabel.text = model.gameTitle
        
        if let discountPrice = model.gameDiscountPrice {
            gameCurrentPrice.text = "\(discountPrice)"
            gameOriginPrice.text = "\(model.gameOriginPrice)"
        } else {
            gameOriginPrice.text = "\(model.gameOriginPrice)"
            gameOriginPrice.isHidden = true
        }
    }
}

