//
//  MainViewController.swift
//  WebViewAndQRCode
//
//  Created by Seokhyun Kim on 2020-11-02.
//

import UIKit
import WebKit
import AVFoundation
import QRCodeReader

class MainViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var qrCodeBtn: UIButton!
    
    //MARK: - Make QRcode reader Object
    // Good practice: create the reader lazily to avoid cpu overload during the
    // initialization and each time we need to scan a QRCode
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    //MARK: - viewDidLoad
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
    //MARK: - fileprivate Method
    //fileprivate only allowed this class
    @objc fileprivate func qrCodeReaderLaunch() {
        // Retrieve the QRCode content
        // By using the delegate pattern
        readerVC.delegate = self

        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            guard let scannedResult = result?.value else {
                return
            }
            print(scannedResult)
            let scannedUrl = URL(string: scannedResult)
            self.webView.load(URLRequest(url: scannedUrl!))
        }

        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
       
        present(readerVC, animated: true, completion: nil)
    }
    
    //MARK: - Delegate Method
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
}

