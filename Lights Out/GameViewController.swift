import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var gameScene : GameScene!
    
    override func viewDidLayoutSubviews() {
        gameScene = GameScene(size: view.bounds.size)
        let skView = self.view as! SKView
        gameScene.scaleMode = .resizeFill
        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gameScene.topInset = view.safeAreaInsets.top //accounts for notch. This is 0 in viewDidLoad(), so have to move here
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
