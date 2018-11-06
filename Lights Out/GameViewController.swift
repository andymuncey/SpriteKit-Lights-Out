import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var gameScene : GameScene!
    
    override func viewDidLayoutSubviews() {
        //create the game scene and configure it a bit
        gameScene = GameScene(size: view.bounds.size)
        gameScene.scaleMode = .resizeFill
        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gameScene.topInset = view.safeAreaInsets.top //accounts for notch. This is 0 in viewDidLoad(), so have to move here
        
        //get the view from this view controller, cast it as a SKView and present the scene
        let skView = self.view as! SKView
        skView.presentScene(gameScene)
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
