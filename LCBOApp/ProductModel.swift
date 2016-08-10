//
//  ProductModel.swift
//  LCBOApp
//
//  Created by Victor Hong on 8/8/16.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

import Foundation
import UIKit

class ProductModel {
    
    var productName: String
    var productPrice: Int
    var imageURL: String

    init(productName: String, productPrice: Int, imageURL: String) {
        self.productName = productName
        self.productPrice = productPrice
        self.imageURL = imageURL
    }
    
}