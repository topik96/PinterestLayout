//
//  PinterestLayout.swift
//  LearningApp
//
//  Created by Topik M on 15/08/22.
//

import Foundation
import UIKit

protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath , cellWidth : CGFloat ) -> CGFloat
}

class PinterestLayout: UICollectionViewFlowLayout {
    
    // MARK: - Properties -
    
    weak var delegate: PinterestLayoutDelegate?
    private let _section: Int = 0
    private let _numberOfColumns: Int = 2
    private let _cellPadding: CGFloat = 8
    private var _cache = [UICollectionViewLayoutAttributes]()
    private var _contentHeight: CGFloat = 0.0
    private var _contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let inset = collectionView.contentInset
        return collectionView.bounds.width - (inset.left + inset.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: _contentWidth, height: _contentHeight)
    }
    
    override func prepare() {
        guard _cache.isEmpty == true, let collectionView = collectionView else { return }
        let columnWidth = _contentWidth / CGFloat(_numberOfColumns)
        var xOffsets = [CGFloat]()
        for column in 0..<_numberOfColumns {
            xOffsets.append(CGFloat(column) * columnWidth)
        }
        
        var column: Int = 0
        var yOffsets: [CGFloat] = .init(repeating: 0, count: _numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: _section) {
            let indexPath = IndexPath(item: item, section: _section)
            let photoHeight = (delegate?.collectionView(collectionView,
                                                        heightForPhotoAtIndexPath: indexPath, cellWidth: columnWidth) ?? 180.0)
            let height = _cellPadding * CGFloat(_numberOfColumns) + photoHeight
            let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: _cellPadding, dy: _cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            _cache.append(attributes)
            _contentHeight = max(_contentHeight, frame.maxY)
            yOffsets[column] =  yOffsets[column] + height
            column = column < (_numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in _cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return _cache[indexPath.item]
    }
}
