//
//  DrawView.swift
//  TouchTracker
//
//  Created by NHN on 2021/04/12.
//

import UIKit

class DrawView: UIView {
    var currentLine: Line?
    var finishedLines = [Line]()
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = 10
        path.lineCapStyle = CGLineCap.round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        
        for line in finishedLines {
            strokeLine(line: line)
        }
        
        if let line = currentLine {
            UIColor.red.setStroke()
            strokeLine(line: line)
        }
    }
    
    // 새로운 선을 만든다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        let location = touch.location(in: self)
        
        currentLine = Line(begin: location, end: location)
        
        // 런 루프의 끝에 뷰를 다시 그린다.
        setNeedsDisplay()
    }
    
    // currentLine 의 end를 갱신하도록
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        currentLine?.end = location
        
        setNeedsDisplay()
    }
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if var line = currentLine {
            let touch = touches.first!
            let location = touch.location(in: self)
            line.end = location
            
            finishedLines.append(line)
        }
        currentLine = nil
        
        setNeedsDisplay()
    }
    
    
}
