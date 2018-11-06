import SpriteKit

protocol LightDelegate {
    func lightPressed(id: Int)
}

class LightNode : SKShapeNode {
    
    //designated initialzer, so we must override it
    override init(){
        super.init()
    }
    
    //required initializer, must implement (even though it wont be used)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private (set) var lit = false
    private var index : Int?
    private var delegate : LightDelegate?
    
    init(rect: CGRect, cornerRadius: CGFloat, index: Int, delegate: LightDelegate){
        //call parent class initialisers
        super.init()
        self.init(rect: rect, cornerRadius: cornerRadius)
        
        //configure the node
        isUserInteractionEnabled = true //ensures that the node can handle touch events
        fillColor = UIColor.purple
        self.index = index
        self.delegate = delegate
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let actualIndex = index {
            delegate?.lightPressed(id: actualIndex)
        }
    }
    
    func toggle(){
        lit.toggle()
        fillColor = lit ? UIColor.yellow : UIColor.purple
    }
}

