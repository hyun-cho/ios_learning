//
//  DrawView.swift
//  TouchTracker
//
//  Created by NHN on 2021/04/12.
//

import UIKit

class DrawView: UIView {
    var currentLines: [NSValue:Line] = [NSValue:Line]()
    var finishedLines = [Line]()
    
    // @IBInspectable 은 속성 인스펙터를 통해 설정하길 원하는 프로퍼티를 인터페이스 빌더에 알려준다.
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
//        UIColor.black.setStroke()
        finishedLineColor.setStroke()
        
        for line in finishedLines {
            strokeLine(line: line)
        }
        
//        UIColor.red.setStroke()
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            strokeLine(line: line)
        }
    }
    
    // 새로운 선을 만든다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let location = touch.location(in: self)
            
            let newLine = Line(begin: location, end: location)
            
            // uiTouch 객체의 주소를 가진 NSValue 인스턴스
            // touch를 직접 키로 사용하지 않는 이유는, strong 레퍼런스를 유지하면 안되기 때문이다. (터치 생명주기와 관련)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        // 런 루프의 끝에 뷰를 다시 그린다.
        setNeedsDisplay()
    }
    
    // currentLine 의 end를 갱신하도록
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        
        setNeedsDisplay()
    }
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                
                finishedLines.append(line)
                
                currentLines.removeValue(forKey: key)
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        currentLines.removeAll()
        
        setNeedsDisplay()
    }
    
    
}
