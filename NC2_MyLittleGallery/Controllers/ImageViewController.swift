//
//  ImageViewController.swift
//  NC2_MyLittleGallery
//
//  Created by Seulki Lee on 2022/09/01.
//

import UIKit

class ImageViewController: UIViewController {
    
    var test = ""
    var imageSent: UIImage?

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = imageSent
        
        print(test)
    }

}
