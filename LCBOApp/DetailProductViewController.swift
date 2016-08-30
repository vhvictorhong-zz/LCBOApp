//
//  DetailProductViewController.swift
//  LCBOApp
//
//  Created by Victor Hong on 8/15/16.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailProductViewController: UIViewController {
    
    var selectedCellIndex = 0
    var productModel: [ProductModel] = []
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var inventoryLabel: UILabel!
    @IBOutlet var styleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let arrayProductModel = productModel[selectedCellIndex]
        
        let imageView = productImageView
        if let urlString = arrayProductModel.imageURL {
            let url = NSURL(string: urlString)
            let placeholderImage = UIImage(named: "noPhotoAvailable")
            imageView.af_setImageWithURL(url!, placeholderImage: placeholderImage)
        }
        idLabel.text = "\(arrayProductModel.id)"
        nameLabel.text = arrayProductModel.productName
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        let price = Double(arrayProductModel.productPrice)
        let costString = formatter.stringFromNumber(price/100)
        
        if let costString = costString {
            priceLabel.text = costString
        }
        typeLabel.text = arrayProductModel.package
        inventoryLabel.text = "\(arrayProductModel.inventory)"
        styleLabel.text = arrayProductModel.style
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
