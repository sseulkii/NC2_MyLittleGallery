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
    
    @IBOutlet var imageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: k.backgroundColor2)
        
        for i in 0..<imageViews.count {
            imageViews[i].accessibilityLabel = k.waterLilies[i]
            imageViews[i].image = UIImage(named: k.waterLilies[i])
            imageViews[i].setRound()
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageViews[i].isUserInteractionEnabled = true
            imageViews[i].addGestureRecognizer(tapGestureRecognizer)
        }
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if tappedImage.accessibilityLabel == k.pickStyle {
            performSegue(withIdentifier: k.segueChooseStyle, sender: self)
        } else {
            print("go to gallery")
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
