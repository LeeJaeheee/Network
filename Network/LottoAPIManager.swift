//
//  LottoAPIManager.swift
//  Network
//
//  Created by 이재희 on 1/16/24.
//

import Foundation
import Alamofire

struct LottoAPIManager {
    
    func callRequest(number: String, completionHandler: @escaping (String) -> Void) {
        // ?뒤에는 쿼리스트링
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        // 추상화 단계 높음 -> String만 전달해도 됨
        // .request(url) 이렇게만 써도 alamofire 내부에서 get으로 인식함
        AF
            .request(url, method: .get)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                    print(success.drwNo)
                    
                    // viewDidLoad에서 요청했지만 요청,응답 시간 걸리므로 화면 뜨고 나서 텍스트 변경됨
                    //self.dateLabel.text = success.drwNoDate
                    completionHandler(success.drwNoDate)
                    
                case .failure(let failure):
                    print("오류 발생")
                }
            }
    }
    
}
