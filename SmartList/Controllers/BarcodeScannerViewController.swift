//
//  BarcodeScannerViewController.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 5/26/19.
//  Copyright © 2019 Oleksandr Gribov. All rights reserved.
//

import UIKit
import AVFoundation

class BarcodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var video = AVCaptureVideoPreviewLayer()
    var session = AVCaptureSession()
    var qrCodeFrameView: UIView?
   // @IBOutlet weak var square: UIImageView!
    
    // MARK: - View Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Scan a Code"
        
        // Creating session
       // session = AVCaptureSession()
        
        // Define capture device
        qrCodeFrameView = UIView()
        
        setupSession()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.stopRunning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        session.startRunning()
    }
   
    
    // MARK: - AVCapture methods
    fileprivate func setupSession() {
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            //            qrCodeFrameView.frame = CGRect(x: 150, y: 150, width: self.view.frame.width/2, height: self.view.frame.height/2)
            //            qrCodeFrameView.center.x = view.center.x
            //            qrCodeFrameView.center.y = view.center.y
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)!
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }catch {
            print ("Error")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        // Add upc
        output.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        //self.view.bringSubviewToFront(square)
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == .ean8 || object.type == .ean13 || object.type == .pdf417 {
                    qrCodeFrameView?.frame = object.bounds
                    if let decodedString = object.stringValue {
                        self.navigateToDetail(decodedString: decodedString)
                        //session.stopRunning()
                    }
                }
            }
        }
        
        
    }
    
    // MARK: - Actions
    func navigateToDetail(decodedString: String) {
        EdamamAPI.upcCode = decodedString
        performSegue(withIdentifier: "upcSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier) {
        case "upcSegue" :
            let destinationVC = segue.destination as! DetailViewController
            
            
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }


}
