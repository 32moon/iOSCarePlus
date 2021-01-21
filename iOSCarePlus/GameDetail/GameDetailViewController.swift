//
//  GameDetailViewController.swift
//  iOSCarePlus
//
//  Created by 이문정 on 2021/01/21.
//

import UIKit

class GameDetailViewController: UIViewController {
    @IBOutlet private weak var containerViewCOntroller: UIView!
    var model: NewGameContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destination = segue.destination as? GameDetailPageViewController
//        destination?.model = model
        (segue.destination as? GameDetailPageViewController)?.model = model
    }
}
