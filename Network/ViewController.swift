//
//  ViewController.swift
//  Network
//
//  Created by 이재희 on 1/16/24.
//

import UIKit
import Alamofire

struct Jack {
    let boxOfficeResult: SmallJack
}

struct SmallJack {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieJack]
}

struct MovieJack {
    let movieNm: String
    let openDt: String
}

class ViewController: UIViewController {

    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var targetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translateButton.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
    }
    
    @objc func translateButtonClicked() {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let parameters: Parameters = [
            "text": sourceTextView.text!,
            "source": "ko",
            "target": "en"
        ]
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "0d3xeduUNTdnEVt4CQNS",
            "X-Naver-Client-Secret": "26mgFWh_ql"
        ]
        AF.request(url, method: .post, parameters: parameters, headers: headers)
    }

}

