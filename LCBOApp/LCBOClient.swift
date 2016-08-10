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
                        
                        guard let productName = productIndex["name"] as? String else {
                            print("could not get product name")
                            return
                        }
                        //print(productName)
                        
                        guard let productPrice = productIndex["price_in_cents"] as? Int else {
                            print("could not get product price")
                            return
                        }
                        //print(productPrice)
                        
                        guard let imageURL = productIndex["image_url"] as? String else {
                            print("could not get product image")
                            return
                        }
                        //print(imageURL)
                        self.productModel.append(ProductModel(productName: productName, productPrice: productPrice, imageURL: imageURL))
                        //let productModel = [ProductModel(productName: productName, productPrice: productPrice, imageURL: imageURL)]
                    }
                }
        }
        
    }
    
    func downloadImage(imageURL: String) {
        
        Alamofire.request(.GET, "https://httpbin.org/image/png")
            .responseImage { response in
                debugPrint(response)
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    print("image download: \(image)")
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