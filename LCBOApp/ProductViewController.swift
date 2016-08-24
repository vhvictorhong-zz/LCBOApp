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

class ProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DataProtocol {

    @IBOutlet var productCollectionView: UICollectionView!
    
    let lcboClient: LCBOClient = LCBOClient()
    var productModel: [ProductModel] = []
    var selectedCellIndex = 0
    
    // request keys
    let headers = ["Authorization": "Token token=MDo5MDY0NmQ2ZS01ZGNiLTExZTYtYTBjZi03N2Q5NGU0YmYzOGI6V1VWWVk5Qmp4MXFOM2FDTGNVTTZvRm1kQ0ppMldkV2EzV0dK"]
    let url = "https://lcboapi.com/products"
    
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
        
        lcboClient.delegate = self
        
        lcboClient.downloadProducts(url, headers: headers)
        
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
    
        return productModel.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! ProductCollectionViewCell
        let product = self.productModel[indexPath.row]
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
        detailProductViewController.productModel = productModel
    }
    
    // MARK: DataProtocol
    
    func gotProducts(products: [ProductModel]) {
        self.productModel = products
        self.productCollectionView.reloadData()
    }
    
    func errorGettingProducts() {
        print("Error fetching products")
    }
    
}
