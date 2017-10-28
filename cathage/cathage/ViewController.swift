//
//  ViewController.swift
//  cathage
//
//  Created by Sky Xu on 10/23/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: Any) {
        let node = SCNNode()
//        make a sphere by set chamferRadius to be 0.5*length 
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.1/2)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        create a 3 dimensional vector, the 3rd element is how far the object is away from the origin
        node.position = SCNVector3(0,0,-0.3)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
//    reset origin point
    func restartSession(){
        self.sceneView.session.pause()
//        remove box node from parent node
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
//        forget about the old origin and make a new one  based on where you are at the moment
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
}

