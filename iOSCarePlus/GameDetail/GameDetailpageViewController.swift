//
//  GameDetailPageViewController.swift
//  iOSCarePlus
//
//  Created by 이문정 on 2021/01/21.
//

import UIKit

class GameDetailPageViewController: UIPageViewController {
    var orderedViewController: [UIViewController]? = []
    var model: NewGameContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        guard let screenShots = model?.screenshots else { return }
        for screenShot in screenShots {
            guard let url = screenShot.images.first?.url else { return }
            let imageViewController = getImageViewController(url: url)
            orderedViewController?.append(imageViewController)
        }
        
        if let firstViewController = orderedViewController?.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    // imageViewController를 만드는 함수
    private func getImageViewController(url:String) -> UIViewController {
        guard let imageViewController: GameDetailImageViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailImageViewController") as? GameDetailImageViewController else { return UIViewController() }
        imageViewController.url = url
        return imageViewController
    }
}

extension GameDetailPageViewController: UIPageViewControllerDataSource {
    
    // 이전으로 슬라이드 했을 때 보여지는 뷰
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = orderedViewController?.firstIndex(of: viewController) else { return nil }
        let beforeIndex: Int = currentIndex - 1
        // out of range 예외 사항 처리작업 진행
        guard beforeIndex >= 0, (orderedViewController?.count ?? 0) > beforeIndex else { return nil }
        
        return orderedViewController?[beforeIndex]
    }
    
    // 다음으로 슬라이드 했을 때 보여지는 뷰
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = orderedViewController?.firstIndex(of: viewController) else { return nil }
        let afterIndex: Int = currentIndex + 1
        
        guard let count = orderedViewController?.count, count > afterIndex else { return nil }
        
        return orderedViewController?[afterIndex]
    }
}
