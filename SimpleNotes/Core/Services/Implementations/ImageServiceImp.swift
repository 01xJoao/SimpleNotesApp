//
//  ImageServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 17/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import UIKit
import AWSS3

class ImageServiceImp : ImageService {
    private let _reportService: ReportService
    
    private let _bucketId = "simplenotesbucket"
    private let _identityPoolId = "eu-west-2:caa648c2-855a-4ecb-bfe3-57eb96fb8efe"
    
    private let _trasferUtility = AWSS3TransferUtility.default()
    private var _imageURL: URL? = nil
    

    init(reportService: ReportService) {
        self._reportService = reportService
        _configureAWSServiceManager()
    }
    
    func _configureAWSServiceManager(){
        let _credentialsProvider = AWSCognitoCredentialsProvider(regionType:.EUWest2, identityPoolId: _identityPoolId)
        let configuration = AWSServiceConfiguration(region:.EUWest2, credentialsProvider: _credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
    
    func uploadImage(image: UIImage, completion: @escaping (String?) -> Void) {
        let img = _createTemporaryImageInDevice(image)
        _uploadImage(img, completion);
    }
    
    func _createTemporaryImageInDevice(_ image: UIImage) -> () -> Data? {
        _imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("image.png")
        return UIImage.pngData(image)
    }
    
    func _uploadImage(_ imageData: () -> Data?, _ completion: @escaping (String?) -> Void){
        do {
            try imageData()?.write(to: _imageURL!)
            let imageKey = UUID().uuidString + ".png";
            
            _trasferUtility.uploadFile(_imageURL!, bucket: _bucketId, key: UUID().uuidString + ".png", contentType: "image/png", expression: AWSS3TransferUtilityUploadExpression()).continueWith(block: { (task) -> Any? in
                
                if let error = task.error {
                    self._reportService.sendError(error: error, message: "Error unable to load image")
                } else if (task.result != nil ) {
                    completion("http://\(self._bucketId).s3.eu-west-2.amazonaws.com/\(imageKey)")
                } else {
                    completion(nil)
                }
                
                return nil;
            })
        } catch let error {
            _reportService.sendError(error: error, message: "Couldn't upload image to S3")
        }
    }
}
