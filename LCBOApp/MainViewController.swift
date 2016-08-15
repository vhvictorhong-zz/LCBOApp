//
//  MainViewController.swift
//  LCBOApp
//
//  Created by Victor Hong on 8/15/16.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // request keys
    let headers = ["Authorization": "Token token=MDo5MDY0NmQ2ZS01ZGNiLTExZTYtYTBjZi03N2Q5NGU0YmYzOGI6V1VWWVk5Qmp4MXFOM2FDTGNVTTZvRm1kQ0ppMldkV2EzV0dK"]
    let url = "https://lcboapi.com/products"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Make request
        LCBOClient.sharedInstance().downloadProducts(url, headers: headers)
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
    }*/
    

}
