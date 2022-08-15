//
//  MetricUtils.swift
//  LearningApp
//
//  Created by Topik M on 15/08/22.
//

import Foundation
import UIKit

class MetricUtils {
    static func imageHeight(source image: Photo, scaledToWidth: CGFloat) -> CGFloat {
        let oldWidth = CGFloat( image.width ?? 0)
        let scaleFactor = scaledToWidth / oldWidth
        let newHeight = CGFloat(image.height ?? 0) * scaleFactor
        return newHeight
    }
    
    static func labelHeight(source text: String?, cellWidth: CGFloat) -> CGFloat {
        let font = UIFont(name: "Helvetica", size: 16.0)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text ?? ""
        label.sizeToFit()
        return label.frame.height
    }
}
