//
//  ViewController.swift
//  IOS-Swift-ARKitFaceTracking02
//
//  Created by Pooya on 2018-11-21.
//  Copyright © 2018 Pooya. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError("Face tracking is not supported on this device")
        }
        sceneView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARFaceTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    

}


extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        var device: MTLDevice!
        device = MTLCreateSystemDefaultDevice()
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)
        node.geometry?.firstMaterial?.fillMode = .lines
        
        return node
    }
    
    func renderer(
        _ renderer: SCNSceneRenderer,
        didUpdate node: SCNNode,
        for anchor: ARAnchor) {
        
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
                return
        }
        faceGeometry.update(from: faceAnchor.geometry)
    }
    
}
