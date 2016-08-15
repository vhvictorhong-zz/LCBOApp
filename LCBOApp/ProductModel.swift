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
    
    var id: Int
    var productName: String
    var productPrice: Int
    var imageURL: String
    var package: String
    var inventory: Int
    var style: String

    init(id: Int, productName: String, productPrice: Int, imageURL: String, package: String, inventory: Int, style: String) {
        self.id = id
        self.productName = productName
        self.productPrice = productPrice
        self.imageURL = imageURL
        self.package = package
        self.inventory = inventory
        self.style = style
    }
    
}