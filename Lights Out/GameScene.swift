import SpriteKit

class GameScene: SKScene, LightDelegate {
    
    private var buttons : Array<LightNode>!
    private var moves = 0
    private var newGameLabel : SKLabelNode!
    private var movesLabel : SKLabelNode?
    private var gameNumberLabel : SKLabelNode?
    
    var topInset = CGFloat(0) //will be used to offset labels on devices with notch
    
    override func didMove(to view: SKView) {
        newGame()
        addNewGameLabel()
    }

    func newGame(){
        drawLightBoard()
        randomLights()
        moves = 0
        updateMovesLabel()
    }
    
    private func addNewGameLabel(){
        newGameLabel = SKLabelNode(text: "New Game")
        newGameLabel.fontName = "Copperplate"
        newGameLabel.fontColor = SKColor.white
        newGameLabel.fontSize = 22.0
        newGameLabel.position = CGPoint(x: 0, y: (frame.size.height/2)-(newGameLabel.frame.height+topInset + 10))
        addChild(newGameLabel)
    }
    
    private func updateMovesLabel(){
        if movesLabel != nil {
            movesLabel!.removeFromParent()
        }
        movesLabel = SKLabelNode(text: "Moves: \(moves)")
        movesLabel!.fontName = "Copperplate"
        movesLabel!.fontColor = SKColor.white
        movesLabel!.fontSize = 14.0
        movesLabel!.position = CGPoint(x: frame.width/2 - (movesLabel!.frame.width/2), y: (frame.size.height/2)-(movesLabel!.frame.height+topInset))
        addChild(movesLabel!)
    }
    
    func gameNumberLabel(number: Int){
        if gameNumberLabel != nil {
            gameNumberLabel!.removeFromParent()
        }
        gameNumberLabel = SKLabelNode(text: "#: \(number)")
        gameNumberLabel!.fontName = "Copperplate"
        gameNumberLabel!.fontColor = SKColor.white
        gameNumberLabel!.fontSize = 14.0
        gameNumberLabel!.position = CGPoint(x:gameNumberLabel!.frame.width/2 - frame.width/2, y: (frame.size.height/2)-(gameNumberLabel!.frame.height+topInset))
        addChild(gameNumberLabel!)
    }
    
    private func incrementMovesCount() {
        moves += 1
        movesLabel?.text = "Moves: \(moves)"
    }
    
    private func drawLightBoard(){
        buttons = Array<LightNode>()
        //centre of canvas is 0,0
        let width = min(frame.size.width, frame.size.height)
        let buttonWidth = width/5
        
        for i in 0...24 {
            
            //grid drawn from bottom left
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
        var gameNumber = ""
        for i in 0...24 {
            if Bool.random() { //use arc4random_uniform(2) == 1 for Swift 4.1 and earlier
                togglePattern(id: i) //ensure that the game can be won, as each press toggles the same lights the player does
                gameNumber.append("1")
                //print(i) //uncomment this to see which lights to turn off to win the game
            }
            else {
                gameNumber.append("0")
            }
        }
        if let gameInt = Int(gameNumber, radix: 2) {
            gameNumberLabel(number: gameInt)
        }
    }
    
    func togglePattern(id: Int){
        //this light
        buttons[id].toggle()
        
        //below
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
        //above
        if id < 20 {
            buttons[id+5].toggle()
        }
    }
    
    func lightPressed(id: Int) {
        
        incrementMovesCount()
        togglePattern(id: id)
        if completed() {
            dropButtons()
        }
    }
    
    private func dropButtons(){
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
        if newGameLabel.frame.contains(touches.first!.location(in: self)) {
            dropButtons()
            let delay = SKAction.wait(forDuration: 1.0)
            let newGame = SKAction.run {
                self.newGame()
            }
            let sequence = SKAction.sequence([delay,newGame])
            run(sequence)
        }
    }
}
