//
//  DetailWebView.swift
//  Project16
//
//  Created by Yury Popov on 05/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//
import WebKit
import UIKit

class DetailWebView: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var url: String!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showWebView()
        
    }
    
    func showWebView() {
        var finalUrl: URL!
        
        switch url {
        case "Rome":
            finalUrl = URL(string: "https://en.wikipedia.org/wiki/Rome")
        case "London":
            finalUrl = URL(string: "https://en.wikipedia.org/wiki/London")
        case "Oslo":
            finalUrl = URL(string: "https://en.wikipedia.org/wiki/Oslo")
        case "Paris":
            finalUrl = URL(string: "https://en.wikipedia.org/wiki/Paris")
        case "Washington DC":
            finalUrl = URL(string: "https://en.wikipedia.org/wiki/Washington")
        default:
            finalUrl = URL(string: "https://ru.wikipedia.org/wiki/")
        }
        webView.load(URLRequest(url: finalUrl!))
        webView.allowsBackForwardNavigationGestures = true
    }
   

}
