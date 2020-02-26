//
//  VrboWeb.swift
//  ieVRBOsearch
//
//  Created by Dustin Mahone on 2/25/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import Foundation
import WebKit

class VrboWeb: ViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var webSearch: String = ""
    
    override func viewDidLoad() {
        sendRequest(urlString: webSearch)
    }
    
    private func sendRequest(urlString: String) {
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
