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
    var filePath: String?
    
    /*var imageData:  UIImage? {
        
        if let filePath = filePath {
            
            if filePath == "error" {
                return UIImage(named: "noPhotoAvailable")
            }
            
            let fileName = (filePath as NSString).lastPathComponent
            let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            let pathArray = [dirPath, fileName]
            let fileURL = NSURL.fileURLWithPathComponents(pathArray)!
            
            return UIImage(contentsOfFile: fileURL.path!)
        }
        
        return nil
    }*/

    init(productName: String, productPrice: Int, imageURL: String) {
        self.productName = productName
        self.productPrice = productPrice
        self.imageURL = imageURL
    }
    
}