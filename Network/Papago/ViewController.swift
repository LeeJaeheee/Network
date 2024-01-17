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

struct Language {
    static let LanguageCode = ["ko": "한국어",
                               "en": "영어",
                               "ja": "일본어",
                               "zh-CN": "중국어(간체)",
                               "zh-TW": "중국어(번체)",
                               "vi": "베트남어",
                               "id": "인도네시아어",
                               "th": "태국어",
                               "de": "독일어",
                               "ru": "러시아어",
                               "es": "스페인어",
                               "it": "이탈리아어",
                               "fr": "프랑스어"
    ]
    static let list: [String] = Array(Language.LanguageCode.values).sorted()
}

class ViewController: UIViewController {

    @IBOutlet var sourceLanguageButton: UIButton!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var targetLanguageButton: UIButton!
    
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var targetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureUI()
        
        sourceLanguageButton.addTarget(self, action: #selector(sourceLanguageButtonClicked), for: .touchUpInside)
        targetLanguageButton.addTarget(self, action: #selector(targetLanguageButtonClicked), for: .touchUpInside)
        changeButton.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
        
        translateButton.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
    }
    
    @objc func sourceLanguageButtonClicked() {
        let vc = storyboard?.instantiateViewController(withIdentifier: PickLanguageViewController.identifier) as! PickLanguageViewController
        vc.navigationItem.title = "이 언어로 입력"
        vc.language = (sourceLanguageButton.titleLabel?.text)!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func targetLanguageButtonClicked() {
        let vc = storyboard?.instantiateViewController(withIdentifier: PickLanguageViewController.identifier) as! PickLanguageViewController
        vc.navigationItem.title = "이 언어로 번역"
        vc.language = (targetLanguageButton.titleLabel?.text)!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeButtonClicked() {
        let tempTitle = sourceLanguageButton.currentTitle
        sourceLanguageButton.setTitle(targetLanguageButton.currentTitle, for: .normal)
        targetLanguageButton.setTitle(tempTitle, for: .normal)
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

extension ViewController {
    
    func configureNavigation() {
        navigationItem.title = "파파고 번역기"
        navigationItem.backButtonTitle = ""
    }
    
    func configureUI() {
        sourceLanguageButton.setPapagoButton()
        sourceLanguageButton.setTitle("한국어", for: .normal)
        targetLanguageButton.setPapagoButton()
        targetLanguageButton.setTitle("영어", for: .normal)
        
        let image = UIImage(systemName: "arrow.left.arrow.right")?.withConfiguration(UIImage.SymbolConfiguration(scale: .small))
        changeButton.setImage(image, for: .normal)
    }
    
}

