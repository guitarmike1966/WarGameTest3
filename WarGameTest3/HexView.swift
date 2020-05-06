//
//  HexView.swift
//  WarGameTest3
//
//  Created by Michael O'Connell on 5/5/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Cocoa

class HexView: NSView {

    private var _tag = -1
    override var tag: Int {
        get {
            return _tag
        }
        set {
            _tag = newValue
        }
    }

    private var _color = NSColor.green
    var color: NSColor {
        get {
            return _color
        }
        set {
            _color = newValue
        }
    }
    
    private var _selected = false
    var selected: Bool {
        get {
            return _selected
        }
        set {
            _selected = newValue
        }
    }

    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        
        self.layer?.backgroundColor = color.cgColor
        
        let hexagonPath = createPath()

        if selected {
            SelectColor.setStroke()
            hexagonPath.lineWidth = 10
        } else {
            unSelectColor.setStroke()
            hexagonPath.lineWidth = 2
        }
        hexagonPath.stroke()

        let maskLayer = CAShapeLayer()
        maskLayer.path = hexagonPath.cgPath
        self.layer?.mask = maskLayer
    }
    
    
    private func createPath() -> HexagonPath {
        let centerX = self.frame.width / 2
        let centerY = self.frame.height / 2
        let lineLength = centerY

        let offsetX = (lineLength * sin(CGFloat.pi / 3)) - 1
        let offsetY = centerY / 2

        let path = HexagonPath()

        path.move(to: NSPoint(x: centerX, y: 1))
        path.line(to: NSPoint(x: centerX + offsetX, y: offsetY))
        path.line(to: NSPoint(x: centerX + offsetX, y: centerY + offsetY))
        path.line(to: NSPoint(x: centerX, y: self.frame.height-1))
        path.line(to: NSPoint(x: centerX - offsetX, y: centerY + offsetY))
        path.line(to: NSPoint(x: centerX - offsetX, y: offsetY))

        path.close()

        return path
    }


    func insideMask(x: CGFloat, y: CGFloat) -> Bool {
        let path = createPath()
        return path.contains(NSPoint(x: x, y: y))
    }

}


class HexagonPath: NSBezierPath {

    var cgPath: CGPath {
      let path = CGMutablePath()
      var points = [CGPoint](repeating: .zero, count: 3)
      for i in 0 ..< self.elementCount {
        let type = self.element(at: i, associatedPoints: &points)

        switch type {
        case .moveTo:
          path.move(to: points[0])

        case .lineTo:
          path.addLine(to: points[0])

        case .curveTo:
          path.addCurve(to: points[2], control1: points[0], control2: points[1])

        case .closePath:
          path.closeSubpath()

        @unknown default:
          break
        }
      }
      return path
    }

    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}
