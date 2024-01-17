//
//  LottoViewController.swift
//  Network
//
//  Created by 이재희 on 1/16/24.
//

import UIKit
// import Alamofire

// 사용할 데이터만 생성
// Codable = Decodable & Encodable
struct Lotto: Codable {
    let drwNo: Int
    let drwNoDate: String
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

class LottoViewController: UIViewController {

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    let manager = LottoAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.callRequest(number: "1102") { value in
            self.dateLabel.text = value
        }
    }
    
    @IBAction func textFieldReturnTapped(_ sender: UITextField) {
        // 공백, 문자 입력 등 처리해주기
        manager.callRequest(number: numberTextField.text!) { value in
            self.dateLabel.text = value
        }
    }

}
