//
//  ViewController.swift
//  Day9-CustomLayoutCollectionView
//
//  Created by Le Phuc on 7/29/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, LPLayoutDelegate {
    @IBOutlet weak var clvListTag: UICollectionView!
    var listTag:[String]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clvListTag.delegate = self
        clvListTag.dataSource = self
        if let layout = clvListTag?.collectionViewLayout as? LPLayoutCV{
            layout.delegate = self
        }
        listTag = ["LeDinhPhuc","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi"]
        //,"Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi","Dinh","Phuc","Dep","Trai","Nhat","The","Gioi","Chem","Nguoi","Nhu","Chem","Chuoi"
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- CollectionViewSetup
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTag.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("test", forIndexPath: indexPath) as! CVCTestTag
        cell.lbText.text = listTag![indexPath.item]
        // Configure the cell
        return cell
    }
    // Custom layout Delegate
    func collectionView(collectionView: UICollectionView, widthForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let font = UIFont.systemFontOfSize(13.0)
        let fontAttributes = [NSFontAttributeName: font]
        let myText = listTag[indexPath.item]
        let size = (myText as NSString).sizeWithAttributes(fontAttributes)
        return size.width
    }
}

