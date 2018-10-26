import SpriteKit

class GameScene: SKScene, LightDelegate {
    
    private var buttons : Array<LightNode>!
    private var restartLabel : SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        newGame()
        newGameLabel()
    }
    
    func newGame(){
        setupLights()
        randomLights()
    }
    
    private func newGameLabel(){
        restartLabel = SKLabelNode(text: "New Game")
        restartLabel.fontName = "Copperplate"
        restartLabel.fontColor = SKColor.white
        let topInset = CGFloat(50.0)
        restartLabel.position = CGPoint(x: 0, y: (frame.size.height/2)-(restartLabel.frame.height+topInset))
        addChild(restartLabel)
    }
    
    private func setupLights(){
        buttons = Array<LightNode>()
        //centre of canvas is 00
        let width = min(frame.size.width, frame.size.height)
        let buttonWidth = width/5
        
        for i in 0...24 {
            
            //grid will start from bottom left
            let row = CGFloat(i % 5)
            let col = CGFloat(i / 5);
            
            let offset = 0 - width/2
            
            let location = CGRect(x: offset + (buttonWidth * row), y: offset + (buttonWidth * col), width: buttonWidth, height: buttonWidth)
            let lightNode = LightNode(rect: location, cornerRadius: buttonWidth/4, index:i, delegate: self)
            
            lightNode.fillColor = SKColor.purple
            lightNode.alpha = 0
            let animation = SKAction.fadeIn(withDuration: 2.0)
            lightNode.run(animation)
            
            addChild(lightNode)
            buttons.append(lightNode)
        }
    }
    
    private func randomLights() {
        for i in 0...24 {
            if Bool.random() { //use arc4random_uniform(2) == 1 for Swift 4.1 and earlier
                pressed(id: i) //ensure that the game can be won, as each press toggles the same lights the player does
                
                //print(i) //uncomment this to see which lights to turn off to win the game
            }
        }
    }
    
    func pressed(id: Int) {
        
        //this light
        buttons[id].toggle()
        
        //above
        if id >= 5 {
            buttons[id-5].toggle()
        }
        //left
        if id % 5 > 0 {
            buttons[id-1].toggle()
        }
        //right
        if id % 5 < 4 {
            buttons[id+1].toggle()
        }
        //below
        if id < 20 {
            buttons[id+5].toggle()
        }
        
        if completed() {
            dropButtons()
        }
    }
    
    private func dropButtons(){
//        for button in buttons {
//            button.physicsBody = SKPhysicsBody(rectangleOf: button.frame.size)
//        }
        var sequence = [SKAction]()
        while !buttons.isEmpty {
            let button = buttons.randomElement()!
            buttons.remove(at: buttons.firstIndex(of: button)!)
            
            let delay = SKAction.wait(forDuration: 0.03)
            let dropButton = SKAction.run {
                button.physicsBody = SKPhysicsBody(rectangleOf: button.frame.size)
                button.physicsBody?.collisionBitMask = 0 // do not collide with anything
            }
            sequence.append(dropButton)
            sequence.append(delay)
        }
            run(SKAction.sequence(sequence))
        
    }
    
    func completed() -> Bool{
        
        for button in buttons {
            if button.lit {
                return false
            }
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if restartLabel.frame.contains(touches.first!.location(in: self)) {
            dropButtons()
            let delay = SKAction.wait(forDuration: 1.0)
            let newGame = SKAction.run {
                self.newGame()
            }
            let sequence = SKAction.sequence([delay,newGame])
            run(sequence)
            //newGame()
            
        }
    }
}
