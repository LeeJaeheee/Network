//
//  MarketViewController.swift
//  Network
//
//  Created by 이재희 on 1/16/24.
//

import UIKit
import Alamofire

struct Market: Codable {
    let market: String
    let korean_name: String
    let english_name: String
}

class MarketViewController: UIViewController {

    @IBOutlet var marketTableView: UITableView!
    
    var list: [Market] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        callRequest()
    }
    
    func configureTableView() {
        marketTableView.delegate = self
        marketTableView.dataSource = self
    }
    
    func callRequest() {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF
            .request(url, method: .get)
            .validate(statusCode: 200..<501)
            .responseDecodable(of: [Market].self) { response in
                switch response.result {
                case .success(let success):
                    dump(success)
                    
                    // 상태코드를 기준으로 처리
                    if response.response?.statusCode == 200 {
                        self.list = success
                        self.marketTableView.reloadData()
                    } else if response.response?.statusCode == 500 {
                        print("오류가 발생했어요. 잠시 후 다시 시도해주세요.")
                    }
                    
                case .failure(let failure):
                    print(failure)
                }
            }
    }

}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell")!
        let data = list[indexPath.row]
        cell.textLabel?.text = list[indexPath.row].market
        cell.detailTextLabel?.text = list[indexPath.row].korean_name
        return cell
    }
    
    
}
