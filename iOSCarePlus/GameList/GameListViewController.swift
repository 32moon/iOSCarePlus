//
//  GameListViewController.swift
//  iOSCarePlus
//
//  Created by 이문정 on 2020/12/17.
//

import Alamofire
import UIKit

class GameListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var newButton: SelectableButton!
    @IBOutlet private weak var saleButton: SelectableButton!
    @IBOutlet private weak var selectedLineConstraint: NSLayoutConstraint!
    
    @IBAction private func newButtonTouchUp(_ sender: Any) {
        newButton.isSelected = true
        saleButton.isSelected = false
//        newButton.select(true)
//        saleButton.select(false)
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.selectedLineConstraint.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    @IBAction private func saleButtonTouchUp(_ sender: Any) {
        newButton.isSelected = false
        saleButton.isSelected = true
        //        newButton.select(false)
        //        saleButton.select(true)
        let constant: CGFloat = saleButton.center.x - newButton.center.x
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.selectedLineConstraint.constant = constant
            self?.view.layoutIfNeeded()
        }
    }
    // 다른곳 에서도 사용할 수 있도록 전역변수로 빼준다.
    // computed프로퍼티(연산프로퍼티) ---> 변수 값을 계산해서 반환해 준다.
    // 원래는 get,retuen형태이지만 get만 있는 경우 다음과 같이 표현이 가능.
    var newGameListURL: String {
        "https://ec.nintendo.com/api/KR/ko/search/new?count=\(newCount)&offset=\(newOffset)"
    }
    var newCount: Int = 10
    var newOffset: Int = 100
    var isEnd: Bool = false
    var model: NewGameResponse? {
        didSet {
            tableView.reloadData() // 비동기 시스템, 불러온 데이터를 테이블 뷰에 다시 리로드해서 보여주도록 한다.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //코드로 오토레이아웃을 잡았을 때는 테이블뷰의 셀을 코드로 등록해 주어야 함.
        //tableView.register(GameItemCodeTableViewCell.self, forCellReuseIdentifier: "GameItemCodeTableViewCell")
        newButton.isSelected = true
        saleButton.isSelected = false
//        newButton.select(true)
//        saleButton.select(false)
        newGameListAPICall()
    }
    
    private func isIndicatorCell(_ indexPath: IndexPath) -> Bool {
        indexPath.row == model?.contents.count
    }
    
    private func newGameListAPICall() {
        // AF로 리퀘스트를 보내는데, 주소는 newGameListURL, 그 결과를 JSON형태로 받아오고 response클로저에서 작업을 진행한다.
        AF.request(newGameListURL).responseJSON { [weak self] response in
            guard let data = response.data else { return }
            let decoder: JSONDecoder = JSONDecoder()
            guard let model: NewGameResponse = try? decoder.decode(NewGameResponse.self, from: data) else {
                return
            }
            if self?.model == nil {
                self?.model = model
            } else {
                if model.contents.isEmpty {
                    self?.isEnd = true
                }
                self?.model?.contents.append(contentsOf: model.contents)
            }
        }
    }
}

extension GameListViewController: UITableViewDelegate {
    // api콜을 먼저 해준다.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isIndicatorCell(indexPath) {
            newOffset += 10
            newGameListAPICall()
        }
    }
}
extension GameListViewController: UITableViewDataSource {
    // 몇개의 셀(열)이 필요한가?
    // 함수 안에 구현부가 return 한줄 일때 return 생략 가능
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isEnd {
            return (model?.contents.count ?? 0)
        } else {
            if model == nil {
                return 0 // 응답받기 전 셀 0 개로 해놓기!
            }
            return (model?.contents.count ?? 0) + 1
        }
    }
    // 셀(열)에 어떤 셀을 보여줄까? -> 스토리보드에서 만든 셀을 가져오는데, 셀은 테이블 뷰에 등록이 되어있다.
    // 타입캐스팅 as로 GameItemTableCell을 UITableView의 하위 타입으로 치환을 해준다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //       let cell = tableView.dequeueReusableCell(withIdentifier: "GameItemCodeTableViewCell", for: indexPath)
        //        return cell
        
        // 맨 마지막 셀이 그려질 때 newGameListAPICall가 호출되고 offSet이 수정된다.
        if isIndicatorCell(indexPath) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IndicatorCell") as? IndicatorCell else { return UITableViewCell() }
            cell.animationIndicatorView()
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameItemTableViewCell", for: indexPath) as? GameItemTableViewCell,
              let content = model?.contents[indexPath.row] else { return UITableViewCell() }
        let model: GameItemModel = GameItemModel(gameTitle: content.formalName,
                                                 gameOriginPrice: 10_000,
                                                 gameDiscountPrice: nil,
                                                 imageURL: content.heroBannerURL
        )
        cell.setModel(model) // 모델 세팅
        return cell
    }
}
