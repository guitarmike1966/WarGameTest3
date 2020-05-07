//
//  GameClasses.swift
//  WarGameTest3
//
//  Created by Michael O'Connell on 5/5/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Foundation
import Cocoa

extension NSColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }

    static let darkGreen = NSColor(hex: "004000")
    static let lightGreen = NSColor(hex: "40FF40")
}


enum GameBoardCellTerrain {
    case Woods
    case Grass
    case Road
    case Desert
    case Tundra
    case Mountain
    case Other

    func toColor() -> NSColor {
        switch self {
        case .Grass:
            return NSColor.lightGreen
        case .Woods:
            return NSColor.darkGreen
        case .Road:
            return NSColor.lightGray
        case .Desert:
            return NSColor.yellow
        case .Tundra:
            return NSColor.white
        case .Mountain:
            return NSColor.darkGray
        default:
            return NSColor.blue
        }
    }
}


class GameBoardCell {
    var terrain: GameBoardCellTerrain
    var selected: Bool
    var view: HexView

    init(terrain: GameBoardCellTerrain) {
        self.terrain = terrain
        self.selected = false
        // self.view = NSImageView(frame: NSRect(x: 0, y: 0, width: CellWidth, height: CellHeight))
        // self.view = NSView(frame: NSRect(x: 0, y: 0, width: CellWidth, height: CellHeight))
        self.view = HexView(frame: NSRect(x: 0, y: 0, width: CellWidth, height: CellHeight))

        self.view.color = terrain.toColor()

//        self.view.wantsLayer = true
//        self.view.layer?.backgroundColor = terrain.toColor().cgColor

        deselectCell()
    }

    func selectCell() {
        self.selected = true
        // self.view.layer?.borderWidth = 3
        // self.view.layer?.borderColor = NSColor.white.cgColor
        // self.view.color = NSColor.white
        self.view.selected = true
        self.view.display()
    }

    func deselectCell() {
        self.selected = false
        // self.view.layer?.borderWidth = 1
        // self.view.layer?.borderColor = NSColor.black.cgColor
        // self.view.color = NSColor.green
        self.view.selected = false
        self.view.display()
    }

}


class GameBoardRow {
    var cells: [GameBoardCell]

    init(initialRow: [GameBoardCellTerrain]) {
        self.cells = []

        for x in 0..<MaxCols {
            if x < initialRow.count {
                self.cells.append(GameBoardCell(terrain: initialRow[x]))
            }
            else {
                self.cells.append(GameBoardCell(terrain: .Grass))
            }

        }
    }
}



class GameBoard {
    var rows: [GameBoardRow]

    init(initialBoard: [[GameBoardCellTerrain]]) {
        self.rows = []

        for y in 0..<MaxRows {
            if y < initialBoard.count {
                self.rows.append(GameBoardRow(initialRow: initialBoard[y]))
            }
            else {
                self.rows.append(GameBoardRow(initialRow: []))
            }
            
        }
    }


    func clearHighlight() {
        for y in 0..<MaxRows {
            for x in 0..<MaxCols {
                if rows[y].cells[x].selected {
                    rows[y].cells[x].deselectCell()
                }
            }
        }
    }


    func highlightCell(x: Int, y: Int) {
        rows[y].cells[x].selectCell()
    }

}
