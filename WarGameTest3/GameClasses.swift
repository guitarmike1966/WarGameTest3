//
//  GameClasses.swift
//  WarGameTest3
//
//  Created by Michael O'Connell on 5/5/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Foundation
import Cocoa


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

        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.green.cgColor
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


enum GameBoardCellTerrain {
    case woods
    case grass
    case road
    case desert
    case tundra
    case mountain
}


class GameBoardRow {
    var cells: [GameBoardCell]

    init() {
        self.cells = []

        for _ in 0..<MaxCols {
            self.cells.append(GameBoardCell(terrain: .grass))
        }
    }
}



class GameBoard {
    var rows: [GameBoardRow]

    init() {
        self.rows = []

        for _ in 0..<MaxRows {
            self.rows.append(GameBoardRow())
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
