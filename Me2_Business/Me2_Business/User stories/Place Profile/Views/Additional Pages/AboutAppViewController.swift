//
//  AboutAppViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/4/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import StoreKit
import SafariServices

class AboutAppViewController: UIViewController {

    @IBOutlet weak var appVersionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func showPrivacyPolicy(_ sender: Any) {
        guard let url = URL(string: "https://api.me2.kz/static/privacy.pdf") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    @IBAction func rateApp(_ sender: Any) {
        SKStoreReviewController.requestReview()
    }
}
