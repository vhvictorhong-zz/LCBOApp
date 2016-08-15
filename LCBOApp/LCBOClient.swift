//
//  LCBOClient.swift
//  LCBOApp
//
//  Created by Victor Hong on 8/9/16.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class LCBOClient {
    
    var productModel = [ProductModel]()
    
    func downloadProducts(url: String, headers: [String: String]) {
        
        Alamofire.request(.GET, "https://lcboapi.com/products", headers: headers)
            .responseJSON { response in
                
                //Parse data
                if let JSON = response.result.value {
                    guard let products = JSON["result"] as? [[String: AnyObject]] else {
                        print("error converting JSON")
                        return
                    }
                    
                    for productIndex in products {
                        
                        guard let id = productIndex["id"] as? Int else {
                            print("could not get product id")
                            return
                        }
                        
                        guard let productName = productIndex["name"] as? String else {
                            print("could not get product name")
                            return
                        }
                        
                        guard let productPrice = productIndex["price_in_cents"] as? Int else {
                            print("could not get product price")
                            return
                        }
                        
                        guard let imageURL = productIndex["image_url"] as? String else {
                            print("could not get product image")
                            return
                        }
                        
                        guard let package = productIndex["package"] as? String else {
                            print("could not get package name")
                            return
                        }
                        
                        guard let inventory = productIndex["inventory_count"] as? Int else {
                            print("could not get inventory count")
                            return
                        }
                        
                        guard let style = productIndex["style"] as? String else {
                            print("could not get style name")
                            return
                        }
                        
                        self.productModel.append(ProductModel(id: id, productName: productName, productPrice: productPrice, imageURL: imageURL, package: package, inventory: inventory, style: style))
                        
                    }
                }
        }
        
    }
        
    class func sharedInstance() -> LCBOClient {
        
        struct Singleton {
            static var sharedInstance = LCBOClient()
        }
        
        return Singleton.sharedInstance
        
    }
}