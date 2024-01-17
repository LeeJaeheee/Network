//
//  BookViewController.swift
//  Network
//
//  Created by 이재희 on 1/17/24.
//

import UIKit
import Alamofire

// MARK: - Book
struct Book: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let status: String
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, url
    }
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

class BookViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    func callRequest(text: String) {
        
        // 만약 한글이나 이모지가 검색이 안된다면 인코딩 처리 필요
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)"
        
        let headers: HTTPHeaders = [
            "Authorization": APIKey.kakao,
        ]
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: Book.self) { response in
                switch response.result {
                case .success(let success):
                    dump(success.documents)
                case .failure(let failure):
                    print(failure)
                }
            }
    }

}

extension BookViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        callRequest(text: searchBar.text!)
    }
    
}
