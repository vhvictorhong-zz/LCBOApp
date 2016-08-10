//
//  ProductViewController.swift
//  LCBOApp
//
//  Created by Victor Hong on 8/9/16.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

import UIKit
import Alamofire

class ProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var productCollectionView: UICollectionView!
    
    var productModel = [ProductModel]()
    
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

        // Make request
        LCBOClient.sharedInstance().downloadProducts(url, headers: headers)
       
    }
    
    // Setup collectionView layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = minimumSpacingPerCell
        layout.minimumInteritemSpacing = minimumSpacingPerCell
        
        var width: CGFloat!
        
        // change collectionView layout depending on orientation
        if UIApplication.sharedApplication().statusBarOrientation.isLandscape == true {
            width = (CGFloat(productCollectionView.frame.size.width) / cellsPerRowInLandscape) - (minimumSpacingPerCell - (minimumSpacingPerCell / cellsPerRowInLandscape))
        } else {
            width = (CGFloat(productCollectionView.frame.size.width) / cellsPerRowInPortrait) - (minimumSpacingPerCell - (minimumSpacingPerCell / cellsPerRowInPortrait))
        }
        
        layout.itemSize = CGSize(width: width, height: width)
        productCollectionView.collectionViewLayout = layout
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }

    
    // Mark: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LCBOClient.sharedInstance().productModel.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! ProductCollectionViewCell
        let product = LCBOClient.sharedInstance().productModel[indexPath.row]
        cell.setupProductModel(product)
        return cell
    }
    
    // Mark: UICollectionViewDelegate

    // Mark: refresh

    @IBAction func refreshButton(sender: AnyObject) {
        productCollectionView.reloadData()
    }
    
}
