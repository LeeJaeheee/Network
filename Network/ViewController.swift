//
//  ViewController.swift
//  Network
//
//  Created by 이재희 on 1/16/24.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    

}

