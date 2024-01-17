//
//  UICollectionViewCell+Extension.swift
//  Network
//
//  Created by 이재희 on 1/17/24.
//

import UIKit

extension UICollectionViewCell: ReusableProtocol {
    static var identifier: String {
        String(describing: self)
    }
}
