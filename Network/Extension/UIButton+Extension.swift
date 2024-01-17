//
//  UIButton+Extension.swift
//  Network
//
//  Created by 이재희 on 1/17/24.
//

import UIKit

extension UIButton {
    
    func setPapagoButton() {
        semanticContentAttribute = .forceRightToLeft
        titleLabel?.font = .systemFont(ofSize: 15)
        titleLabel?.textColor = .black
        tintColor = .black
        
        let image = UIImage(systemName: "chevron.down")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 7))
        setImage(image, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
    
}
