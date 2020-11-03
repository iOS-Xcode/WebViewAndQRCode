//
//  MainViewController.swift
//  WebViewAndQRCode
//
//  Created by Seokhyun Kim on 2020-11-02.
//

import UIKit
import WebKit

class MainViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var qrCodeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.naver.com")
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
        
        //set qrcode button
        qrCodeBtn.layer.borderWidth = 3
        qrCodeBtn.layer.borderColor = UIColor.blue.cgColor
        qrCodeBtn.layer.cornerRadius = 10
        qrCodeBtn.addTarget(self, action: #selector(qrCodeReaderLaunch), for: .touchUpInside)
    }
    //fileprivate only allowed this class
    @objc fileprivate func qrCodeReaderLaunch() {
        
    }

}

