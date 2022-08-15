//
//  UICollectionView+Extension.swift
//  LearningApp
//
//  Created by Topik M on 15/08/22.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func setMessage(_ message : String , icon : String){
        
        let view = UIView()
        _ = self.frame
        self.backgroundView = view
        
        let msgLab = UILabel()
        msgLab.textAlignment = .center
        msgLab.textColor = .lightGray
        msgLab.numberOfLines = 2
        msgLab.text = message
        view.addSubview(msgLab)
        
        
        let img  = UIImageView()
        img.image = UIImage(named: icon)
        img.tintColor = .lightGray
        img.contentMode = .scaleAspectFit
        view.addSubview(img)
        
        img.translatesAutoresizingMaskIntoConstraints = false
        msgLab.translatesAutoresizingMaskIntoConstraints = false
        
        img.setSize(width: 50, height: 50)
        img.center(centerX: view.centerXAnchor , paddingX: 0 , centerY: view.centerYAnchor , paddingY: -50)
        msgLab.anchor(top: img.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: view.leadingAnchor, paddingLeft: 10, right: view.trailingAnchor, paddingRight: -10, width: 0, height: 30)
        
    }
    
    func toggleActivityIndicator()  {
        
        if let indicator = backgroundView as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
        else {
            let indicator = UIActivityIndicatorView()
            indicator.style = .large
            indicator.color = .red
            indicator.hidesWhenStopped = true
            backgroundView = indicator
            indicator.startAnimating()
        }
    }
}













