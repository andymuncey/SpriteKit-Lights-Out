//
//  LightNode.swift
//  Lights Out
//
//  Created by Andrew Muncey on 26/10/2018.
//  Copyright © 2018 Andrew Muncey. All rights reserved.
//

import SpriteKit

protocol LightDelegate {
    
    func pressed(id: Int)
    
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
            delegate?.pressed(id: actualIndex)
        }
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
   //     delegate?.pressed(id: index != nil ? index! : 0)
    }
    
    
    func toggle(){
        lit.toggle()
        fillColor = lit ? UIColor.yellow : UIColor.purple
    }
    
    
    
}

