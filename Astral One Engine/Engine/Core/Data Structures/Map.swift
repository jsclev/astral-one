import Foundation
import GameplayKit

public class Map {
    public let mapId: Int
    public let width: Int
    public let height: Int
    private var grid: [[Tile]]
    private var movementCosts: [[Double]]
    
    public init(mapId: Int, width: Int, height: Int) {
        self.mapId = mapId
        self.width = width
        self.height = height
        
        self.grid = Array(repeating: Array(repeating: Tile(row: 0,
                                                           col: 0,
                                                           terrain: Terrain(id: 0,
                                                                            tiledId: 0,
                                                                            name: "None",
                                                                            type: TerrainType.None,
                                                                            food: 0.0,
                                                                            shields: 0.0,
                                                                            trade: 0.0,
                                                                            movementCost: Constants.minMovementCost)),
                                           count: width), count: height)

        
        for row in 0..<height {
            for col in 0..<width {
                self.grid[row][col] = Tile(row: row,
                                           col: col,
                                           terrain: Terrain(id: 0,
                                                            tiledId: 0,
                                                            name: "1",
                                                            type: TerrainType.None,
                                                            food: 0.0,
                                                            shields: 0.0,
                                                            trade: 0.0,
                                                            movementCost: Constants.minMovementCost))
            }
        }
        
        self.movementCosts = Array(repeating: Array(repeating:0.0, count: width), count: height)
    }
    
    public func load(mapId: Int) {
        
    }
    
    public func add(tile: Tile) throws {
        if tile.row < 0 {
            let errorMsg = "Row must be greater than or equal to zero."
            throw MapError.invalidRow(message: errorMsg, row: tile.row)
        }
        
        if tile.row >= height {
            let errorMsg = "Row must be less than map height of \(height)."
            throw MapError.invalidRow(message: errorMsg, row: tile.row)
        }
        
        if tile.col < 0 {
            let errorMsg = "Column must be greater than or equal to zero."
            throw MapError.invalidCol(message: errorMsg, col: tile.col)
        }
        
        if tile.col >= width {
            let errorMsg = "Column must be less than map width of \(width)."
            throw MapError.invalidCol(message: errorMsg, col: tile.col)
        }
        
        grid[tile.row][tile.col] = tile
        movementCosts[tile.row][tile.col] = tile.getMovementCost()
    }
    
    public func tile(row: Int, col: Int) throws -> Tile {
        if row < 0 {
            let errorMsg = "Row must be greater than or equal to zero."
            throw MapError.invalidRow(message: errorMsg, row: row)
        }
        
        if row >= height {
            let errorMsg = "Row must be less than map height of \(height)."
            throw MapError.invalidRow(message: errorMsg, row: row)
        }
        
        if col < 0 {
            let errorMsg = "Column must be greater than or equal to zero."
            throw MapError.invalidCol(message: errorMsg, col: col)
        }
        
        if col >= width {
            let errorMsg = "Column must be less than map width of \(width)."
            throw MapError.invalidCol(message: errorMsg, col: col)
        }
        
        return grid[row][col]
    }
    
    public func getGrid() -> [[Tile]] {
        return grid
    }
    
    public func getUnits(row: Int, col: Int) -> [Unit] {
        return grid[row][col].getUnits()
    }
    
    public func getMovementCosts() -> [[Double]] {
        return movementCosts
    }
    
    public func getNumLayers() -> Int {
        var numLayers: Int = 1
        
        for row in 0..<width {
            for col in 0..<height {
                let myLayerCount = grid[row][col].getUnits().count
                if myLayerCount > numLayers {
                    numLayers = myLayerCount
                }
            }
        }

        return numLayers
    }
    
    public func log() {
        print("****************************************************************")
        print("Map dimensions: [\(width), \(height)]")
        
        for row in 0..<width {
            for col in 0..<height {
                let tile = grid[row][col]
                print("Node [\(row),\(col)]: \(tile.getUnits().count) units.")
//                    for tile in node.getTiles() {
//                        if let tileType = Constants.tiles[tile.id] {
//                            if let tileGroup = tileset.tileGroups.first(where: { $0.name == tileType }) {
//                                unitsMap.setTileGroup(tileGroup, forColumn: col, row: row)
//                            }
//                        }
//                    }
            }
        }
        
        print("****************************************************************")
    }
    
    public func getDistance(fromRow: Int, fromCol: Int, toRow: Int, toCol: Int) -> Int {
        return abs(toRow - fromRow) + abs(toCol - fromCol) + 1
    }
    
    
}
