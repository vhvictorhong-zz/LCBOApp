//
//  ProductCollectionViewCell.swift
//  LCBOApp
//
//  Created by Victor Hong on 8/9/16.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    func setupProductCell(productModel: ProductModel) {
        
        // Convert price to currency style
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        let price = Double(productModel.productPrice)
        let costString = formatter.stringFromNumber(price/100)
        
        // Display text
        self.productNameLabel.text = productModel.productName
        if let costString = costString {
            self.productPriceLabel.text = "Price: \(costString)"
        }
        
        // Download and set placeholder image
        let imageView = UIImageView(frame: frame)
        if let urlString = productModel.imageURL {
            let url = NSURL(string: urlString)
            let placeholderImage = UIImage(named: "noPhotoAvailable")
            imageView.af_setImageWithURL(url!, placeholderImage: placeholderImage)
            self.backgroundView = imageView
        }
        
    }
    
}
