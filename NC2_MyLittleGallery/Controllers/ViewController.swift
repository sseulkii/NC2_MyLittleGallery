//
//  ViewController.swift
//  NC2_MyLittleGallery
//
//  Created by Seulki Lee on 2022/09/01.
//

import UIKit

// https://stackoverflow.com/questions/27880607/how-to-assign-an-action-for-uiimageview-object-in-swift
class ViewController: UIViewController {
    
    let k = K()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageOne: UIImageView!
    
    @IBOutlet weak var imageTwo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 180/250, green: 207/250, blue: 176/250, alpha: 1)
        
        imageOne.image = UIImage(named: "waterlily1")
        imageTwo.image = UIImage(named: "waterlily2")
        
        imageOne.setRound()
        imageTwo.setRound()
        
        
        let tapGestureRecognizerOne = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageOne.isUserInteractionEnabled = true
        imageOne.addGestureRecognizer(tapGestureRecognizerOne)
        
        let tapGestureRecognizerTwo = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageTwo.isUserInteractionEnabled = true
        imageTwo.addGestureRecognizer(tapGestureRecognizerTwo)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if tappedImage == imageOne {
            performSegue(withIdentifier: k.segueChooseStyle, sender: self)
        } else {
            print("go to gallery")
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == k.segueChooseStyle {
            let destinationVC = segue.destination as! StylesViewController
            destinationVC.test = "tesing"
        }
    }

}

extension UIImageView {
    
    func setRound() {
        
        self.layer.cornerRadius = (self.frame.height / 2)
        self.layer.masksToBounds = false
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.clipsToBounds = true
        
    }
}
