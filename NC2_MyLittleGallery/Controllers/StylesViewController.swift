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
    
    // 이거 배열에 담을 수 없을까? 넘 지저분하고 반복되는거라
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
        
        view.backgroundColor = UIColor(named: k.backgroundColor1)
        
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
        
        let tapGestureRecognizerMonet = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        monetButton.isUserInteractionEnabled = true
        monetButton.addGestureRecognizer(tapGestureRecognizerMonet)
        
        let tapGestureRecognizerDegas = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        degasButton.isUserInteractionEnabled = true
        degasButton.addGestureRecognizer(tapGestureRecognizerDegas)

        let tapGestureRecognizerRenoir = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        renoirButton.isUserInteractionEnabled = true
        renoirButton.addGestureRecognizer(tapGestureRecognizerRenoir)

        let tapGestureRecognizerManet = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        manetButton.isUserInteractionEnabled = true
        manetButton.addGestureRecognizer(tapGestureRecognizerManet)

        let tapGestureRecognizerCassatt = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cassattButton.isUserInteractionEnabled = true
        cassattButton.addGestureRecognizer(tapGestureRecognizerCassatt)

        let tapGestureRecognizerSisley = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        sisleyButton.isUserInteractionEnabled = true
        sisleyButton.addGestureRecognizer(tapGestureRecognizerSisley)

        let tapGestureRecognizerMorisot = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        morisotButton.isUserInteractionEnabled = true
        morisotButton.addGestureRecognizer(tapGestureRecognizerMorisot)

        let tapGestureRecognizerPissarro = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pissarroButton.isUserInteractionEnabled = true
        pissarroButton.addGestureRecognizer(tapGestureRecognizerPissarro)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        switch tappedImage {
        case monetButton:
            chosenStyle = MyStyleTransferMonet().model
        case degasButton:
            chosenStyle = MyStyleTransferDegas().model
        case renoirButton:
            chosenStyle = MyStyleTransferRenoir().model
        case manetButton:
            chosenStyle = MyStyleTransferManet().model
        case cassattButton:
            chosenStyle = MyStyleTransferCassatt().model
        case sisleyButton:
            chosenStyle = MyStyleTransferSisley().model
        case morisotButton:
            chosenStyle = MyStyleTransferMorisot().model
        case pissarroButton:
            chosenStyle = MyStyleTransferPissarro().model
        default:
            print("error")
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

