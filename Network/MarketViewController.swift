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

    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
    }
    
    func callRequest() {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF
            .request(url, method: .get)
            .responseDecodable(of: [Market].self) { response in
                switch response.result {
                case .success(let success):
                    //print(success)
                    print(success[0].korean_name)
                case .failure(let failure):
                    print(failure)
                }
            }
    }

}
