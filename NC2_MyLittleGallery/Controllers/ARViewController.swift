//
//  ARViewController.swift
//  NC2_MyLittleGallery
//
//  Created by Seulki Lee on 2022/09/01.
//

import UIKit
import ARKit

// https://stackoverflow.com/questions/51888939/place-image-from-gallery-on-a-wall-using-arkit
class ARViewController: UIViewController, ARSCNViewDelegate {
    
    var imageToShow: UIImage?

    @IBOutlet weak var sceneView: ARSCNView!
    
    let arSession = ARSession()
    let configuration = ARWorldTrackingConfiguration()
    var additionalNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.session = arSession
        sceneView.delegate = self
        configuration.planeDetection = .vertical
        arSession.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if additionalNode == nil {
            guard let planeAnchor = anchor as? ARPlaneAnchor else {
                return
            }
            
            let width = CGFloat(imageToShow!.size.width * 0.002)
            let height = CGFloat(imageToShow!.size.height * 0.002)
            
            additionalNode = SCNNode(geometry: SCNPlane(width: width, height: height))
            
            additionalNode?.eulerAngles.x = -.pi / 2
            
            additionalNode?.geometry?.firstMaterial?.diffuse.contents = imageToShow
            
            node.addChildNode(additionalNode!)
        }
        
    }

}
