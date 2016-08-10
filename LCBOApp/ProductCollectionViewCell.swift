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
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        let price = Double(productModel.productPrice)
        let costString = formatter.stringFromNumber(price/100)
        self.productNameLabel.text = productModel.productName
        self.productPriceLabel.text = costString
        print(productModel.productName)
        print(productModel.productPrice)
    }
    
    
}
