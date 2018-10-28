import SpriteKit

protocol LightDelegate {
    func lightPressed(id: Int)
}

class LightNode : SKShapeNode {
    
    //designated initialzer, so we must override it
    override init(){
        super.init()
    }
    
    private (set) var lit = false;
    private var index : Int?
    private var delegate : LightDelegate?
    
    init(rect: CGRect, cornerRadius: CGFloat, index: Int, delegate: LightDelegate){
        super.init()
        self.init(rect: rect, cornerRadius: cornerRadius)
        isUserInteractionEnabled = true
        fillColor = UIColor.purple
        self.index = index
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

