//
//  StylesViewController.swift
//  NC2_MyLittleGallery
//
//  Created by Seulki Lee on 2022/09/01.
//

import UIKit
import CoreML
import Vision
import VideoToolbox

class StylesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    let k = K()
    
    let imagePicker = UIImagePickerController()
    
    var chosenStyle: MLModel?
    
    var pickedImage: UIImage?
    
    @IBOutlet var artistImages: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: k.backgroundColor1)
        

        for i in 0..<artistImages.count {
            artistImages[i].accessibilityLabel = k.artistNames[i]
            artistImages[i].image = UIImage(named: k.artistNames[i])
            artistImages[i].setRound()
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            artistImages[i].isUserInteractionEnabled = true
            artistImages[i].addGestureRecognizer(tapGestureRecognizer)
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary

    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        switch tappedImage.accessibilityLabel {
        case k.monet:
            chosenStyle = k.artStyleModels[k.monet]
        case k.renoir:
            chosenStyle = k.artStyleModels[k.renoir]
        case k.degas:
            chosenStyle = k.artStyleModels[k.degas]
        case k.cassatt:
            chosenStyle = k.artStyleModels[k.cassatt]
        case k.morisot:
            chosenStyle = k.artStyleModels[k.morisot]
        case k.manet:
            chosenStyle = k.artStyleModels[k.manet]
        case k.pissarro:
            chosenStyle = k.artStyleModels[k.pissarro]
        case k.sisley:
            chosenStyle = k.artStyleModels[k.sisley]
        default:
            print("something's gone wrong")
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == k.segueShowImage {
            let destinationVC = segue.destination as! ImageViewController
            destinationVC.imageSent = pickedImage
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("could not convert to CIImage")
            }
            
            guard let artistModel = chosenStyle else {
                fatalError("could not convert mlmodel")
            }
            convert(image: ciImage, transferModel: artistModel)

        }
        
        performSegue(withIdentifier: k.segueShowImage, sender: self)
        imagePicker.dismiss(animated: true)
        
    }
    
    func convert(image: CIImage, transferModel: MLModel) {

        guard let model = try? VNCoreMLModel(for: transferModel) else {
            fatalError("could not load model")
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            guard let transfer = request.results as? [VNPixelBufferObservation] else {
                fatalError("could not transfer image style")
            }

            guard let image = transfer.first?.pixelBuffer else {
                fatalError("error processing image style transfer")
            }

            self.pickedImage = UIImage(pixelBuffer: image)
        }

        let handler = VNImageRequestHandler(ciImage: image)

        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }

}

extension UIImage {
    public convenience init?(pixelBuffer: CVPixelBuffer) {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)

        guard let cgImage = cgImage else {
            return nil
        }

        self.init(cgImage: cgImage)
    }
}

