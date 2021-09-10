//
//  ViewController.swift
//  ch08-1234567-cameraCoreML
//
//  Created by Jae Moon Lee on 2021/04/13.
//

import UIKit
import Vision
import CoreML

class StillImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var flowerLabel: UILabel!
    
    var request :VNCoreMLRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(takePicture))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        
        self.navigationItem.title = "Flower Classification"
        
        //messageLabel.layer.borderWidth = 2
        //messageLabel.layer.borderColor = UIColor.black.cgColor
        messageLabel.text = "[사진 고르기]"
        
        request = createCoreMLRequest(modelName: "Oxford102", modelExt: "mlmodelc", completionHandler: handleImageClassifier)
    }
}

extension StillImageViewController{
    @objc func takePicture(sender: UITapGestureRecognizer){
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickerController.sourceType = .camera
        }else{
            imagePickerController.sourceType = .photoLibrary
        }
        
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension StillImageViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
            
            let handler = VNImageRequestHandler(ciImage: CIImage(image: image)!)
            try! handler.perform([request])
            
            
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension StillImageViewController{
    func createCoreMLRequest(modelName: String, modelExt: String, completionHandler: @escaping (VNRequest, Error?) -> Void) -> VNCoreMLRequest? {
       
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: modelExt) else{
            return nil
        }

        guard let vnCoreMLModel = try? VNCoreMLModel(for: MLModel(contentsOf: modelURL)) else{
            return nil
        }
        return VNCoreMLRequest(model: vnCoreMLModel, completionHandler: completionHandler)
    }
    
    func handleImageClassifier(request: VNRequest, error: Error?){
        guard let results = request.results as? [VNClassificationObservation] else{
            return
        }
        if let topResult = results.first{
            DispatchQueue.main.async{
                self.messageLabel.text = ""
                //print(topResult.identifier)
                self.flowerLabel.text = topResult.identifier
            }
        }
    }
}

extension StillImageViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoViewController = segue.destination as! InfoViewController
        infoViewController.city = "no"
        infoViewController.stilFlower = flowerLabel.text
    }
}
