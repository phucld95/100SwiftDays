//
//  LPLayoutCV.swift
//  Day9-CustomLayoutCollectionView
//
//  Created by Le Phuc on 7/29/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit


protocol LPLayoutDelegate {
    // 1 Get height of item.
//    func collectionView(collectionView:UICollectionView, heightForItemAtIndexPath indexPath:NSIndexPath) -> CGFloat
    // 2 Get width of item.
    func collectionView(collectionView:UICollectionView, widthForItemAtIndexPath indexPath:NSIndexPath) -> CGFloat
    // 3 Get padding of item.
//    func collectionView(collectionView:UICollectionView, paddingForItemAtIndexPath indexPath:NSIndexPath) -> UIEdgeInsets
}

class LPLayoutAttributes:UICollectionViewLayoutAttributes {
    
    // 1. Custom attribute
    var heightItem: CGFloat = 0.0
    var widthItem: CGFloat = 0.0
    
    // 2. Override copyWithZone to conform to NSCopying protocol
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = super.copyWithZone(zone) as! LPLayoutAttributes
        copy.heightItem = heightItem
        copy.widthItem = widthItem
        return copy
    }
    
    // 3. Override isEqual
    override func isEqual(object: AnyObject?) -> Bool {
        if let attributtes = object as? LPLayoutAttributes {
            if( attributtes.heightItem == heightItem && attributtes.widthItem == widthItem ) {
                return super.isEqual(object)
            }
        }
        return false
    }
}

class LPLayoutCV: UICollectionViewLayout {
    //Your layout subclass must implement the following 3 methods:
/*
     prepareLayout(): This method is called whenever a layout operation is about to take place. It’s your opportunity to prepare and perform any calculations required to determine the collection view size and the positions of the items.
     Phương thức này sẽ được gọi đến mỗi khi việc set vị trí của 1 item sắp diễn ra. Mothod thường được sử dụng để cài đặt các tính toán để chuẩn bị trước việc xác định kích thước của các item.
     
     collectionViewContentSize(): In this method, you have to return the height and width of the entire collection view content — not just the visible content. The collection view uses this information internally to configure its scroll view content size.
     Phương thức này sẽ trả lại chiều cao, chiều rộng của item. Bao gồm tất cả các item có trong collection view (không chỉ những item hiển thị).
     
     
     layoutAttributesForElementsInRect(_:): In this method you need to return the layout attributes for all the items inside the given rectangle. You return the attributes to the collection view as an array of UICollectionViewLayoutAttributes.
    Phương thức này sẽ trả lại vị trí (tọa độ) của item dưới dạng một hình chữ nhật.
*/

    //Thông thường khi làm custom layout chúng ta hay nói đến bài toán tính toán động. Nghĩa là vị trí, kích thước của các item sẽ bị phụ thuộc vào dữ liệu nó thể hiện ở bên trong. Để làm được việc này thì chúng ta phải sử dụng kèm với một protocal để file này có thể biết được nội dung nó cần hiển thị từ bên ngoài là gì.
    //1. Pinterest Layout Delegate
    
    
    
    
    //1. LP Layout Delegate
    var delegate:LPLayoutDelegate!
    
    //2. Array to keep a cache of attributes.
    private var cache = [LPLayoutAttributes]()
    
    //3. Content height and size
    private var contentHeight:CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    override class func layoutAttributesClass() -> AnyClass {
        return LPLayoutAttributes.self
    }
    
    override func prepareLayout() {
        // 1. Only calculate once
        if cache.isEmpty {
            // 3. Iterates through the list of items in the first section
            // collectionView: Đối tượng collectionView đang sở hữu file custom layout.
            
            var tempXOffset: CGFloat = 0
            var tempYOffset: CGFloat = 0
            let inset: CGFloat = 4
            
            tempYOffset = tempYOffset + 30
            tempXOffset = inset
            for item in 0 ..< (collectionView?.numberOfItemsInSection(0))! {
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                let itemWidth = delegate.collectionView(collectionView!, widthForItemAtIndexPath: indexPath) + 10
                print("item width in LPLayout: \(itemWidth)")
                if (tempXOffset + inset + itemWidth) > contentWidth {
                    //TODO
                    // Trường hợp item cuối bị hạn chế hơn chiều dài của collectionView.
                    // Trường hợp này phải dàn lại toàn bộ nội dung phía trước sao cho mỗi cái đều bị bớt đi 1 tí.
                    // Kết thúc quá trình này sẽ tăng chiều cao của item lên 1 khoảng giống như việc xuống dòng.
//                    let frame = CGRect(x: tempXOffset, y: tempYOffset, width: itemWidth, height: 26)
//                    let insetItem = CGRectInset(frame, inset, inset)
//                    let attributes = LPLayoutAttributes(forCellWithIndexPath: indexPath)
//                    attributes.heightItem = 22
//                    attributes.frame = insetItem
//                    cache.append(attributes)
                    tempXOffset = inset
                    tempYOffset = tempYOffset + 30
                }
//                else {
                    //TODO
                    // Trường hợp item chỉ là bình thường vẫn nằm trong phạm vi của collectionView.
                    // 4. Asks the delegate for the width of text and calculates the item frame.
                    let frame = CGRect(x: tempXOffset, y: tempYOffset, width: itemWidth, height: 26)
                    let insetItem = CGRectInset(frame, inset, inset)
                    // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
                    let attributes = LPLayoutAttributes(forCellWithIndexPath: indexPath)
                    attributes.heightItem = 22
                    attributes.frame = insetItem
                    cache.append(attributes)
                    tempXOffset = tempXOffset + inset + itemWidth
                contentHeight = tempYOffset + 30
//                }
            }
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes  in cache {
            if CGRectIntersectsRect(attributes.frame, rect ) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }

}
