//
//  DataProtocol.swift
//  LCBOApp
//
//  Created by Victor Hong on 8/24/16.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

import Foundation

protocol DataProtocol {
    
    func gotProducts(products: [ProductModel])
    func errorGettingProducts()
    
}