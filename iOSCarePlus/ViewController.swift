//
//  ViewController.swift
//  iOSCarePlus
//
//  Created by 이문정 on 05/12/2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var logoView: UIView!
    @IBOutlet private weak var logoViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var backgroundImageViewLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoView.layer.cornerRadius = 15
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            animationSettingDefault()
            appearLogoViewAnimation { [weak self] in
                self?.slideBackgroundImageAnimation()
                self?.blinkLogoAnimation()
            }
        }
        
        private func animationSettingDefault() {
            logoViewTopConstraint.constant = -200
            logoView.alpha = 1
            backgroundImageViewLeadingConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        
        private func appearLogoViewAnimation(completion: (() -> Void)? = nil) {
            UIView.animate(
                withDuration: 0.7,
                delay: 1,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 1,
                options: [],
                animations: { [weak self] in
                    self?.logoViewTopConstraint.constant = 17
                    self?.view.layoutIfNeeded()
                },
                completion: { _ in
                    completion?()
                })
        }
        
        private func slideBackgroundImageAnimation() {
            UIView.animate(
                withDuration: 5,
                delay: 0,
                options: [.curveEaseInOut, .repeat, .autoreverse]
            ) { [weak self] in
                self?.backgroundImageViewLeadingConstraint.constant = -800
                self?.view.layoutIfNeeded()
            }
        }
        
        private func blinkLogoAnimation() {
            UIView.animate(
                withDuration: 1,
                delay: 0,
                options: [.repeat, .autoreverse]
            ) { [weak self] in
                self?.logoView.alpha = 0
                self?.view.layoutIfNeeded()
            }
        }
    }
