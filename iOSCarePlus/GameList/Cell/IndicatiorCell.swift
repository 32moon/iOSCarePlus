//
//  IndicatiorCell.swift
//  iOSCarePlus
//
//  Created by 이문정 on 2020/12/25.
//

import UIKit

class IndicatorCell: UITableViewCell {

    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    func animationIndicatorView() {
        activityIndicatorView.startAnimating()
    }
}
