//
//  BookCollectionViewCell.swift
//  Network
//
//  Created by 이재희 on 1/17/24.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 12
        
        backgroundColor = UIColor(red: CGFloat.random(in: 0...1),
                                  green: CGFloat.random(in: 0...1),
                                  blue: CGFloat.random(in: 0...1),
                                  alpha: 0.5)
        
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateLabel.font = .boldSystemFont(ofSize: 11)
        
        imageView.contentMode = .scaleToFill
    }
    
    func configureCell(data: Document) {
        titleLabel.text = data.title
        dateLabel.text = formatDateString(data.datetime)
        imageView.kf.setImage(with: URL(string: data.thumbnail))
    }
    
    func formatDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        
        let string = String(dateString.split(separator: "T")[0])
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: string)
        
        dateFormatter.dateFormat = "M.dd"
        return dateFormatter.string(from: date!)
    }

}
