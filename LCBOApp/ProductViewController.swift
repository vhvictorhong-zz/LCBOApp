//
//  ProductViewController.swift
//  LCBOApp
//
//  Created by Victor Hong on 8/9/16.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

import UIKit
import Alamofire
import HanabiCollectionViewLayout
import AlamofireNetworkActivityIndicator

class ProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var productCollectionView: UICollectionView!
    var productModel = [ProductModel]()
    var selectedCellIndex = 0
    
    // collectionView layout initializer
    let cellReuseIdentifier = "ProductCollectionViewCell"
    
    let cellsPerRowInPortrait: CGFloat = 1
    let cellsPerRowInLandscape: CGFloat = 2
    let minimumSpacingPerCell: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set collection dataSource and delegate
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
    }
    
    // Setup collectionView layout
    override func viewDidLayoutSubviews() {
        
        let layout = HanabiCollectionViewLayout()
        layout.standartHeight = 200.00
        layout.focusedHeight = 350.00
        layout.dragOffset = 200.00
        
        productCollectionView.collectionViewLayout = layout
        
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return LCBOClient.sharedInstance().productModel.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! ProductCollectionViewCell
        let product = LCBOClient.sharedInstance().productModel[indexPath.row]
        cell.setupProductCell(product)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedCellIndex = indexPath.row
        self.performSegueWithIdentifier("showDetailProductViewController", sender: self)
    }

    // MARK: refresh

    @IBAction func refreshButton(sender: AnyObject) {
        productCollectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailProductViewController = segue.destinationViewController as! DetailProductViewController
        detailProductViewController.selectedCellIndex = self.selectedCellIndex
    }
    
}
