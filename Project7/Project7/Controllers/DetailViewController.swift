//
//  DetailViewController.swift
//  Project7
//
//  Created by Yury Popov on 21/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        let text = """
        Project7 from 100 days
        https://www.hackingwithswift.com/
        """
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 250%; } </style>
        </head>
        <body>
        <h2 style="font-style:italic; text-align:center"><span style="font-size:28px"><span style="color:#d35400"><span style="font-family:Comic Sans MS,cursive">\(detailItem.body)</span></span></span>
        <h2 style="font-style:italic"><span style="font-family:Verdana,Geneva,sans-serif"><span style="font-size:18px">\(text)</span></span></h2>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        
    }
    

   
    
}
