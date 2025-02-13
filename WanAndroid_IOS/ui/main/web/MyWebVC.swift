//
//  MyWebVC.swift
//  WanAndroid_IOS
//
//  Created by 雷富 on 2020/5/21.
//  Copyright © 2020 雷富. All rights reserved.
//

import UIKit
import WebKit

/// 阅读记录 2022-10-19
/// 功能：自定义 web 容器，用来加载 url
class MyWebVC: UIViewController {
    
    var url : String?
    
    convenience init(title: String? , url: String?) {
        self.init()
        self.title = title
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = title ?? "网页"
        // 添加 webview
        let webView = WKWebView.init(frame: view.frame)
        
        if url != nil {
            webView.load(URLRequest.init(url: URL.init(string: url!)!))
        }
        
        self.view.addSubview(webView)
    }
}
