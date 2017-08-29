//
//  CameraControl.swift
//  TemplateProject
//
//  Created by Scott Pelo on 8/14/17.
//  Copyright © 2017 Adam Arthur. All rights reserved.
//

import UIKit
import AVFoundation

protocol CameraControlDelegate {
    func getImage(image: UIImage)
}

class CameraControl: UIView, AVCapturePhotoCaptureDelegate {
    
    var delegate: CameraControlDelegate?
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var cameraView: UIView?
    var imageResult: UIImage?
    var videoDeviceInput: AVCaptureDeviceInput?
    var captureDevice: AVCaptureDevice?
    var stillImageOutput: AVCaptureStillImageOutput?
    
    private weak var borderLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        captureDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front)
        initializeCamera()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeCamera() {
        do {
            videoDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(videoDeviceInput!)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = self.layer.bounds
            cameraView = UIView()
            self.addSubview(cameraView!)
            cameraView?.frame = self.bounds
            cameraView?.layer.addSublayer(videoPreviewLayer!)
            captureSession?.startRunning()
            self.stillImageOutput = AVCaptureStillImageOutput.init()
            self.stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            self.captureSession?.addOutput(stillImageOutput)
        } catch {
            print(error)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // create path
        
        let width = min(bounds.width, bounds.height)
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: width / 2, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        // update mask and save for future reference
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        // create border layer
        
        let frameLayer = CAShapeLayer()
        frameLayer.path = path.cgPath
        frameLayer.lineWidth = 5.0
        frameLayer.strokeColor = UIColor.white.cgColor
        frameLayer.fillColor = nil
        
        // if we had previous border remove it, add new one, and save reference to new one
        
        borderLayer?.removeFromSuperlayer()
        layer.addSublayer(frameLayer)
        borderLayer = frameLayer
    }
    
    func captureImage() {
        if let videoConnection = stillImageOutput?.connection(withMediaType:AVMediaTypeVideo) {
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: {
                (sampleBuffer, error) in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                let dataProvider = CGDataProvider.init(data: imageData! as CFData)
                let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
                let image = UIImage.init(cgImage: cgImageRef!, scale: 1.0, orientation: .leftMirrored)
                self.delegate?.getImage(image: self.cropImageToSquare(image: image)!)
            })
        }
    }
    
    func cropImageToSquare(image: UIImage) -> UIImage? {
        var imageHeight = image.size.height
        var imageWidth = image.size.width
        
        if imageHeight > imageWidth {
            imageHeight = imageWidth
        } else {
            imageWidth = imageHeight
        }
        
        let size = CGSize(width: imageWidth, height: imageHeight)
        
        let refWidth : CGFloat = CGFloat(image.cgImage!.width)
        let refHeight : CGFloat = CGFloat(image.cgImage!.height)
        
        let x = (refWidth - size.width) / 2
        let y = (refHeight - size.height) / 2
        
        let cropRect = CGRect(x: x, y: y, width: size.height, height: size.width)
        if let imageRef = image.cgImage!.cropping(to: cropRect) {
            return UIImage(cgImage: imageRef, scale: 0, orientation: image.imageOrientation)
        }
        
        return nil
    }
}
