import Foundation
import GameplayKit
import Combine

public class Map {
    public let mapId: Int
    public let width: Int
    public let height: Int
    private var grid: [[Tile]]
    private var movementCosts: [[Double]]
    private var players: [Player] = []
    private var cancellable = Set<AnyCancellable>()

    
    public init(mapId: Int, width: Int, height: Int) {
        self.mapId = mapId
        self.width = width
        self.height = height
        
        self.grid = Array(repeating: Array(repeating: Tile(position: Position(row: 0, col: 0),
                                                           terrain: Terrain(id: 0,
                                                                            tiledId: 0,
                                                                            name: "Grass",
                                                                            type: TerrainType.Grassland)),
                                           count: width), count: height)

        
        for row in 0..<height {
            for col in 0..<width {
                self.grid[row][col] = Tile(position: Position(row: row, col: col),
                                           terrain: Terrain(id: 0,
                                                            tiledId: 0,
                                                            name: "1",
                                                            type: TerrainType.Grassland))
            }
        }
        
        self.movementCosts = Array(repeating: Array(repeating:0.0, count: width), count: height)
    }
    
    public func load(mapId: Int) {
        
    }
    
    public func add(tile: Tile) {
        grid[tile.position.row][tile.position.col] = tile
        movementCosts[tile.position.row][tile.position.col] = tile.getMovementCost()
    }
    
    public func tile(at: Position) -> Tile {       
        return grid[at.row][at.col]
    }
    
    public func add(player: Player) {
        players.append(player)
        
//        player.$units
//            .dropFirst()
//            .sink(receiveValue: { units in
//                if let newUnit = units.last {
//                    do {
//                        try self.tile(row: newUnit.position.row,
//                                      col: newUnit.position.col).add(unit: newUnit)
//                    }
//                    catch {
//                        fatalError("\(error)")
//                    }
//                }
//            })
//            .store(in: &cancellable)

    }
    
//    public func add(unit: Unit) throws {
//        try tile(row: unit.position.row, col: unit.position.col).add(unit: unit)
//    }
    
    public func getGrid() -> [[Tile]] {
        return grid
    }
    
    public func getUnits(row: Int, col: Int) -> [Unit] {
        return []
//        return grid[row][col].getUnits()
    }
    
    public func getMovementCosts() -> [[Double]] {
        return movementCosts
    }
    
    public func getNumLayers() -> Int {
        return 1
//        var numLayers: Int = 1
        
//        for row in 0..<width {
//            for col in 0..<height {
//                let myLayerCount = grid[row][col].getUnits().count
//                if myLayerCount > numLayers {
//                    numLayers = myLayerCount
//                }
//            }
//        }

//        return numLayers
    }
    
    public func log() {
//        print("****************************************************************")
//        print("Map dimensions: [\(width), \(height)]")
//
//        for row in 0..<width {
//            for col in 0..<height {
//                let tile = grid[row][col]
//                print("Node [\(row),\(col)]: \(tile.getUnits().count) units.")
//                    for tile in node.getTiles() {
//                        if let tileType = Constants.tiles[tile.id] {
//                            if let tileGroup = tileset.tileGroups.first(where: { $0.name == tileType }) {
//                                unitsMap.setTileGroup(tileGroup, forColumn: col, row: row)
//                            }
//                        }
//                    }
//            }
//        }
//
//        print("****************************************************************")
    }
    
    public func getDistance(fromRow: Int, fromCol: Int, toRow: Int, toCol: Int) -> Int {
        return abs(toRow - fromRow) + abs(toCol - fromCol) + 1
    }
    
    
}
