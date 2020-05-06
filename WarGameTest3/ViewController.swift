//
//  ViewController.swift
//  WarGameTest3
//
//  Created by Michael O'Connell on 5/5/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Cocoa

let MaxRows = 10
let MaxCols = 15
let CellHeight: CGFloat = 100
let CellWidth: CGFloat = CellHeight * 0.865
let Padding: CGFloat = 20

let SelectColor = NSColor.white
let unSelectColor = NSColor.black


class ViewController: NSViewController {

    @IBOutlet weak var BoardView: NSView!

    var mainBoard = GameBoard()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        BoardView.wantsLayer = true

        BoardView.layer?.backgroundColor = NSColor.lightGray.cgColor

        BoardView.layer?.borderWidth = 1
        BoardView.layer?.borderColor = .black

        mainBoard = GameBoard()

        for y in 0..<MaxRows {
            for x in 0..<MaxCols {
                var newX = Padding + (CGFloat(x) * (CellWidth * 0.98))
                if (y % 2 == 1) {
                    newX = newX + (CellWidth / 2) - 1
                }

                let newY = Padding + (CGFloat(y) * ((CellHeight * 0.74)))

                mainBoard.rows[y].cells[x].view.frame = NSRect(x: newX, y: newY, width: CellWidth, height: CellHeight)
                mainBoard.rows[y].cells[x].view.tag = (y * 1000) + x

                BoardView.addSubview(mainBoard.rows[y].cells[x].view)

                let tapGesture = NSClickGestureRecognizer()
                tapGesture.target = self
                tapGesture.buttonMask = 0x1   // left button
                tapGesture.numberOfClicksRequired = 1
                tapGesture.action = #selector(self.click(g:))
                mainBoard.rows[y].cells[x].view.addGestureRecognizer(tapGesture)
            }
        }

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    @objc func click(g:NSGestureRecognizer) {

        if let v = g.view as? HexView {

            let touchpoint = g.location(in: v)

            if v.insideMask(x: touchpoint.x, y: touchpoint.y) {
                // print("Inside Hexagon : \(v.tag)")

                let y: Int = v.tag / 1000
                let x: Int = v.tag % 1000

                if (mainBoard.rows[y].cells[x].selected) {
                    mainBoard.rows[y].cells[x].deselectCell()
                }
                else {
                    mainBoard.clearHighlight()
                    mainBoard.rows[y].cells[x].selectCell()
                }

            }
            else {
//                print("Outside Hexagon")
            }

        }
    }

}

