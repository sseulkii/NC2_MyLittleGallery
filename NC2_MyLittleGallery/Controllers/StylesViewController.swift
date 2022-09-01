//
//  StylesViewController.swift
//  NC2_MyLittleGallery
//
//  Created by Seulki Lee on 2022/09/01.
//

import UIKit

class StylesViewController: UIViewController {
    
    var test = ""
    
    let k = K()
    
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
        
        print(test)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
