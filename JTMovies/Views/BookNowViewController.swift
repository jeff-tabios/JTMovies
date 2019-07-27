//
//  BookNowViewController.swift
//  JTMovies
//
//  Created by Jeff Tabios on 26/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import UIKit
import WebKit

class BookNowViewController: UIViewController {
    
    @IBOutlet weak var wb: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.cathaycineplexes.com.sg/")!
        wb.load(URLRequest(url: url))
        wb.allowsBackForwardNavigationGestures = true
    }
    
}
