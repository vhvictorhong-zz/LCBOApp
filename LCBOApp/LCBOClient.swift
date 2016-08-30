//
//  LCBOClient.swift
//  LCBOApp
//
//  Created by Victor Hong on 8/9/16.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

import Foundation
import Alamofire

class LCBOClient {
    
    var delegate: DataProtocol?
    var isLoading = false
    
    func downloadProducts(searchQuery: String, pageNumber: Int) {
        
        if self.isLoading {
            return
        }
        
        self.isLoading = true
        
        let headers = [
            "Authorization": "Token token=\(Constants.APIKey)"
        ]
        
        let parameters = [URLKeys.SearchQuery: "\(searchQuery)",
                           URLKeys.Page: "\(pageNumber)"]
        
        Alamofire.request(.GET, Constants.BaseURL, parameters: parameters, headers: headers)
            .responseJSON { response in
                
                //Parse data
                if let JSON = response.result.value {
                    var productModel: [ProductModel] = []
                    guard let products = JSON["result"] as? [[String: AnyObject]] else {
                        print("error converting JSON")
                        return
                    }
                    
                    for productIndex in products {
                        
                        let id = productIndex["id"] as! Int
                        let productName = productIndex["name"] as! String
                        let productPrice = productIndex["price_in_cents"] as! Int
                        let imageURL = productIndex["image_url"] as? String
                        let package = productIndex["package"] as! String
                        let inventory = productIndex["inventory_count"] as? Int
                        let style = productIndex["style"] as? String
                        
                        let productArray = ProductModel(id: id, productName: productName, productPrice: productPrice, imageURL: imageURL, package: package, inventory: inventory, style: style)
                        productModel.append(productArray)
                        
                    }
                    self.delegate?.gotProducts(productModel, pageNumber: pageNumber)
                    self.isLoading = false
                    return
                }
                self.delegate?.errorGettingProducts()
                self.isLoading = false
        }
        
    }
    
}