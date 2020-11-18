//
//  NewsWebViewController.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 13.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        loadWebView()
    }
    
    private func loadWebView() {
        guard let urlData = url else { return }
        let url = URL(string: urlData)
        
        if let urlFinal = url {
            let request = URLRequest(url: urlFinal)
            webView.load(request)
        }
        webView.allowsBackForwardNavigationGestures = true
    }
}

extension NewsWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation")
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        decisionHandler(.allow)
    }
}
