//
//  GameDetailImageViewController.swift
//  iOSCarePlus
//
//  Created by 이문정 on 2021/01/21.
//

import Kingfisher
import UIKit

class GameDetailImageViewController: UIViewController {
    var url: String?
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let stringURL = url else { return }
        let url = URL(string: stringURL)
        imageView.kf.setImage(with: url)
    }

}
