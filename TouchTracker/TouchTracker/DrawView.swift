//
//  DrawView.swift
//  TouchTracker
//
//  Created by NHN on 2021/04/12.
//

// UIGestureRecognizerState는 7가지 상태를 가질 수 있다.
// 구현하지 않은 Recognizer는 UIPinchGesture, UISwipeGesture, UIScreenEdgePanGesture, UIRotationGesture다.

import UIKit

// UIGestureRecognizerDelegate 프로토콜을 따른다.
class DrawView: UIView, UIGestureRecognizerDelegate {
    var currentLines: [NSValue:Line] = [NSValue:Line]()
    var finishedLines = [Line]()
    var selectedLineIndex: Int? {
        didSet {
            if selectedLineIndex == nil {
                let menu = UIMenuController.shared
                menu.hideMenu(from: self)
            }
        }
    }
    var moveRecognizer: UIPanGestureRecognizer!
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // double tap이 발생하게되면, UIResponder 메서드 호출을 가로챈다.
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapRecognizer.numberOfTouchesRequired = 2
        // 터치용으로 인식할 제스처가 남아있다면 뷰에서 began 호출을 지연시킨다.
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapRecognizer.delaysTouchesBegan = true
        //
        tapRecognizer.require(toFail: doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        addGestureRecognizer(longPressRecognizer)
        
        let moveRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveLine))
        // true이면 제스처 인식기는 제스처를 인식하고 나서 터치를 "먹는다" -> 선을 그릴 수 없다.
        moveRecognizer.cancelsTouchesInView = false
        moveRecognizer.delegate = self
        addGestureRecognizer(moveRecognizer)
    }
    
    @objc func doubleTap(gestureRecognizer: UIGestureRecognizer) {
        print("Recognize double tap")
        
        selectedLineIndex = nil
        currentLines.removeAll()
        finishedLines.removeAll()
        setNeedsDisplay()
    }
    @objc func tap(gestureRecognizer: UIGestureRecognizer) {
        print("Recognize a tap")
        
        // tap을 통해서 select 한다.
        let point = gestureRecognizer.location(in: self)
        selectedLineIndex = indexOfLine(point: point)
        
        
        let menu = UIMenuController.shared
        
        if selectedLineIndex != nil {
            // DrawView를 메뉴 아이템 액션 메시지의 타깃
            becomeFirstResponder()
            
            // "delete" UIMenuItem 을 만든다.

            let deleteItem = UIMenuItem(title: "Delete", action: #selector(deleteLine))
            menu.menuItems = [deleteItem]
            
            // 메뉴의 영역과 위치에 보이게 설정
            //'setTargetRect(_:in:)' was deprecated in iOS 13.0: Use showMenuFromView:rect: instead.
            //'setMenuVisible(_:animated:)' was deprecated in iOS 13.0: Use showMenuFromView:rect: or hideMenuFromView: instead.
//            menu.setTargetRect(CGRect(x: point.x, y: point.y, width: 2, height: 2), in: self)
//            menu.setMenuVisible(false, animated: true)
            menu.showMenu(from: self, rect: CGRect(x: point.x, y: point.y, width: 2, height: 2))
        }
        else {
            // 선택 된 선이 없다면, 메뉴를 숨긴다.
            //setMenuVisible(_:animated:)' was deprecated in iOS 13.0: Use showMenuFromView:rect: or hideMenuFromView: instead.
//            menu.setMenuVisible(false, animated: true)
            menu.hideMenu(from: self)
        }
        setNeedsDisplay()
    }
    
    @objc func longPress(gestureRecognizer: UIGestureRecognizer) {
        print("Recognize a long press")
        
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: self)
            selectedLineIndex = indexOfLine(point: point)
            
            if selectedLineIndex != nil {
                currentLines.removeAll(keepingCapacity: false)
            }
        }
        else if gestureRecognizer.state == .ended {
            selectedLineIndex = nil
        }
        setNeedsDisplay()
    }
    
    @objc func moveLine(gestureRecognizer: UIPanGestureRecognizer) {
        print("Recognized a pan")
        // 선을 선택
        if let index = selectedLineIndex {
            // 팬 인식기의 위치가 변화하면
            if gestureRecognizer.state == .changed {
                let translation = gestureRecognizer.translation(in: self)
                // 선의 현재 시작과, 끝 지점에 이동 값을 더함
                
                finishedLines[index].begin.x += translation.x
                finishedLines[index].begin.y += translation.y
                finishedLines[index].end.x += translation.x
                finishedLines[index].end.y += translation.y
                
                gestureRecognizer.setTranslation(CGPoint.zero, in: self)
                
                setNeedsDisplay()
            }
        }
        else {
            return
        }
    }
    
    func indexOfLine(point: CGPoint) -> Int? {
        // point와 가까운 선
        for (index, line) in finishedLines.enumerated() {
            let begin = line.begin
            let end = line.end
            
            for t in stride(from: CGFloat(0), to: 1, by: 0.05) {
                let x = begin.x + (end.x - begin.x) * t
                let y = begin.y + (end.y - begin.y) * t
                
                
                if hypot(x - point.x, y - point.y) < 20.0 {
                    return index
                }
            }
        }
        return nil
    }
    
    @objc func deleteLine(sender: AnyObject) {
        // finishedLines 목록에서 선택한 선을 제거한다.
        if let index = selectedLineIndex {
            finishedLines.remove(at: index)
            selectedLineIndex = nil
            
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
    
    // 첫 인자는 참고를 위해 요청한 제스처 인식기
    // 또 다른 Recognizer가 있어도, 하나만 인식되도록 한다. default는 false
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
