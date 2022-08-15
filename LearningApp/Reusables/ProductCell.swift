//
//  ProductCell.swift
//  LearningApp
//
//  Created by Topik M on 15/08/22.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: Any? {
        didSet {
            guard let photo = item as? Photo else { return }
            photoImageView.kf.setImage(with: URL(string: photo.downloadUrl ?? ""))
            { res in
                if case .success(let value) = res {
                    ImageCache.default.store(value.image, forKey: photo.downloadUrl ?? "")
                }
            }
            titleLabel.text = photo.desc
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _commonInit()
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        item =  nil
    }
    
    deinit {
        item = nil
    }
    
    
    private func _commonInit() {
        layer.cornerRadius = 8
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        photoImageView.backgroundColor = .gray
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont(name: "Helvetica", size: 16)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
