//
//  ProductCollectionViewCell.swift
//  LCBOApp
//
//  Created by Victor Hong on 8/9/16.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    
    func setupProductModel(productModel: ProductModel) {
        
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
        let URL = NSURL(string: productModel.imageURL)
        let placeholderImage = UIImage(named: "noPhotoAvailable")
        imageView.af_setImageWithURL(URL!, placeholderImage: placeholderImage)
        self.backgroundView = imageView
        
    }
    
    
}
