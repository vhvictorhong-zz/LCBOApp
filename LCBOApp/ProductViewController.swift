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
    @IBOutlet var searchField: UITextField!
    
    let lcboClient: LCBOClient = LCBOClient()
    var productModel: [ProductModel] = []
    var selectedCellIndex = 0
    var currentPageNumber = 1
    
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
        
        lcboClient.downloadProducts("", pageNumber: currentPageNumber)
        
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y + scrollView.bounds.height >= scrollView.contentSize.height {
            // when we scroll to the bottom of the collection view's content view (plus a small offset), load more rows
            lcboClient.downloadProducts(searchField.text ?? "", pageNumber: self.currentPageNumber + 1)
        }
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
    
    func gotProducts(products: [ProductModel], pageNumber: Int) {
        
        self.currentPageNumber = pageNumber
        
        if products.count == 0 {
            return
        }
        
        productModel.appendContentsOf(products)
        
        // add more items to collectionview
        let firstRowToInsert = self.productCollectionView.numberOfItemsInSection(0)
        var indexPathsToInsert: [NSIndexPath] = []
        for row in firstRowToInsert...firstRowToInsert + products.count - 1 {
            indexPathsToInsert.append(NSIndexPath(forRow: row, inSection: 0))
        }
        self.productCollectionView.insertItemsAtIndexPaths(indexPathsToInsert)
        
    }
    
    func errorGettingProducts() {
        print("Error fetching products")
    }
    
    // MARK: Search Button
    
    @IBAction func searchButton(sender: AnyObject) {
        
        self.productModel = []
        self.productCollectionView.reloadData()
        self.lcboClient.downloadProducts(searchField.text ?? "", pageNumber: 1)
        
    }
    
}
