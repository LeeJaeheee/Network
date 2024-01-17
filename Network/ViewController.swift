//
//  ViewController.swift
//  Network
//
//  Created by 이재희 on 1/16/24.
//

import UIKit
import Alamofire

/*
 {
     "message": {
         "@type": "response",
         "@service": "naverservice.nmt.proxy",
         "@version": "1.0.0",
         "result": {
             "srcLangType": "ko",
             "tarLangType": "en",
             "translatedText": "Hello",
             "engineType": "PRETRANS"
         }
     }
 }
 */
struct Papago: Codable {
    let message: PapagoMessage
}

struct PapagoMessage: Codable {
    let result: PapagoResult
}

struct PapagoResult: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
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
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        AF.request(url, method: .post, parameters: parameters, headers: headers)
            .responseDecodable(of: Papago.self) { response in
                switch response.result {
                case .success(let success):
                    dump(success)
                    self.targetLabel.text = success.message.result.translatedText
                case .failure(let failure):
                    print(failure)
                }
            }
    }

}

