//
//  ImageViewController.swift
//  NC2_MyLittleGallery
//
//  Created by Seulki Lee on 2022/09/01.
//

import UIKit

class ImageViewController: UIViewController {
    
    let k = K()
    var test = ""
    var imageSent: UIImage?

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: k.accentColor)

        imageView.image = imageSent
        
        print(test)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        if let imageToSave = imageSent {
            UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            let alert = UIAlertController(title: "Error", message: "There was an error saving your image.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Image Saved", message: "Your image has been saved in your photo library.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    @IBAction func showOnWall(_ sender: Any) {
        performSegue(withIdentifier: k.segueShowOnWall, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == k.segueShowOnWall {
            let destinationVC = segue.destination as! ARViewController
            if let image = imageSent {
                destinationVC.imageToShow = image
            }
        }
    }
}
