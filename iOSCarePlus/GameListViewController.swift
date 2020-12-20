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
    // 다른곳 에서도 사용할 수 있도록 전역변수로 빼준다.
    let newGameListURL: String = "https://ec.nintendo.com/api/KR/ko/search/new?count=30&offset=0"
    var model: NewGameResponse? {
        didSet {
            tableView.reloadData() // 비동기 시스템, 불러온 데이터를 테이블 뷰에 다시 리로드해서 보여주도록 한다.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGameListAPICall()
    }
    
    private func newGameListAPICall() {
        // AF로 리퀘스트를 보내는데, 주소는 newGameListURL, 그 결과를 JSON형태로 받아오고 response클로저에서 작업을 진행한다.
        AF.request(newGameListURL).responseJSON { [weak self] response in
            guard let data = response.data else { return }
            let decoder: JSONDecoder = JSONDecoder()
            let model: NewGameResponse? = try? decoder.decode(NewGameResponse.self, from: data)
            self?.model = model
        }
    }
}

extension GameListViewController: UITableViewDelegate {
}

extension GameListViewController: UITableViewDataSource {
    // 몇개의 셀(열)이 필요한가?
    // 함수 안에 구현부가 return 한줄 일때 return 생략 가능
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.contents.count ?? 0
    }
    
    // 셀(열)에 어떤 셀을 보여줄까? -> 스토리보드에서 만든 셀을 가져오는데, 셀은 테이블 뷰에 등록이 되어있다.
    // 타입캐스팅 as로 GameItemTableCell을 UITableView의 하위 타입으로 치환을 해준다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameItemTableViewCell", for: indexPath) as? GameItemTableViewCell,
        let content = model?.contents[indexPath.row] else { return UITableViewCell() }
        let model = GameItemModel(gameTitle: content.formalName, gameOriginPrice: 10_000, gameDiscountPrice: nil, imageURL: content.heroBannerURL)
        cell.setModel(model) // 모델 세팅
        return cell
    }
}
