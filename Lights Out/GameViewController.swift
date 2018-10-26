//
//  GameViewController.swift
//  Lights Out
//
//  Created by Andrew Muncey on 26/10/2018.
//  Copyright © 2018 Andrew Muncey. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //let viewB = SKView(frame: self.view.frame)
        let sceneB = GameScene(size: view.bounds.size)
        let skView = self.view as! SKView
        sceneB.scaleMode = .resizeFill
        sceneB.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        skView.presentScene(sceneB)
        
        
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .resizeFill                       //todo: changed
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
