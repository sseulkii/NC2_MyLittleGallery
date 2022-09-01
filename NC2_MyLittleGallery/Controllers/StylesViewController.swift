//
//  StylesViewController.swift
//  NC2_MyLittleGallery
//
//  Created by Seulki Lee on 2022/09/01.
//

import UIKit

class StylesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    let k = K()
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var monetButton: UIImageView!
    @IBOutlet weak var degasButton: UIImageView!
    @IBOutlet weak var renoirButton: UIImageView!
    @IBOutlet weak var manetButton: UIImageView!
    @IBOutlet weak var cassattButton: UIImageView!
    @IBOutlet weak var sisleyButton: UIImageView!
    @IBOutlet weak var morisotButton: UIImageView!
    @IBOutlet weak var pissarroButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 229/250, green: 227/250, blue: 201/250, alpha: 1.0)
        
        monetButton.image = UIImage(named: k.monet)
        degasButton.image = UIImage(named: k.degas)
        renoirButton.image = UIImage(named: k.renoir)
        manetButton.image = UIImage(named: k.manet)
        cassattButton.image = UIImage(named: k.cassatt)
        sisleyButton.image = UIImage(named: k.sisley)
        morisotButton.image = UIImage(named: k.morisot)
        pissarroButton.image = UIImage(named: k.pissarro)
        
        monetButton.setRound()
        degasButton.setRound()
        renoirButton.setRound()
        manetButton.setRound()
        cassattButton.setRound()
        sisleyButton.setRound()
        morisotButton.setRound()
        pissarroButton.setRound()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        monetButton.isUserInteractionEnabled = true
        monetButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == k.segueShowImage {
            let destinationVC = segue.destination as! ImageViewController
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("could not convert to CIImage")
            }
            
//            guard let artistModel = mlModels[userPickedArtist] else {
//                fatalError("could not convert mlmodel")
//            }
//            convert(image: ciImage, transferModel: artistModel)

        }
        
        imagePicker.dismiss(animated: true)
        
    }
    
//    func convert(image: CIImage, transferModel: MLModel) {
//
//        guard let model = try? VNCoreMLModel(for: transferModel) else {
//            fatalError("could not load model")
//        }
//
//        let request = VNCoreMLRequest(model: model) { request, error in
//            guard let transfer = request.results as? [VNPixelBufferObservation] else {
//                fatalError("could not transfer image style")
//            }
//
//            guard let image = transfer.first?.pixelBuffer else {
//                fatalError("error processing image style transfer")
//            }
//
//            self.imageView.image = UIImage(pixelBuffer: image)
//            self.pickedImage = UIImage(pixelBuffer: image)
//
//        }
//
//        let handler = VNImageRequestHandler(ciImage: image)
//
//        do {
//            try handler.perform([request])
//        } catch {
//            print(error)
//        }
//    }

}
