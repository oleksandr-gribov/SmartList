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
   // @IBOutlet weak var square: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Scan a Code"
        
        // Creating session
       // session = AVCaptureSession()
        
        // Define capture device
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
   
    func navigateToDetail(decodedString: String) {
        EdamamAPI.upcCode = decodedString
        performSegue(withIdentifier: "upcSegue", sender: self)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == .ean8 || object.type == .ean13 || object.type == .pdf417 {
                    if let decodedString = object.stringValue {
                        self.navigateToDetail(decodedString: decodedString)
                        session.stopRunning()
                    }
                }
            }
        }
        
        
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
