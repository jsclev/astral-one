import Foundation
import GameplayKit
import Combine

public class Map: ObservableObject {
    public let mapId: Int
    public let width: Int
    public let height: Int
    private var grid: [[Tile]]
    private var movementCosts: [[Double]]
    private var cancellable = Set<AnyCancellable>()
    @Published internal var cities: [City] = []
    
    public convenience init(width: Int, height: Int) {
        self.init(mapId: Constants.noId, width: width, height: height)
    }

    public init(mapId: Int, width: Int, height: Int) {
        self.mapId = mapId
        self.width = width
        self.height = height
        
        let nullPosition = Position(row: 0, col: 0)
        let nullTerrain = Terrain(id: Constants.noId,
                                  tiledId: Constants.noId,
                                  name: "",
                                  type: TerrainType.Unknown)
        self.grid = Array(repeating: Array(repeating: Tile(position: nullPosition,
                                                           terrain: nullTerrain,
                                                           hasRiver: false),
                                           count: width),
                          count: height)

        for row in 0..<height {
            for col in 0..<width {
                self.grid[row][col] = Tile(position: Position(row: row, col: col),
                                           terrain: Terrain(id: Constants.noId,
                                                            tiledId: Constants.noId,
                                                            name: "Null",
                                                            type: TerrainType.Unknown),
                                                            hasRiver: false)
            }
        }
        
        self.movementCosts = Array(repeating: Array(repeating:0.0, count: width), count: height)
    }
    
    public var visibleTiles: [Tile] {
        var tiles: [Tile] = []
        
        for row in 0..<height {
            for col in 0..<width {
                if grid[row][col].visibility != Visibility.FogOfWar {
                    tiles.append(grid[row][col])
                }
            }
        }
        
        return tiles
    }
    
    public func isFullyVisible(position: Position) -> Bool {
        return tile(at: position).visibility == Visibility.FullyRevealed
    }
    
    public func load(mapId: Int) {
        
    }
    
    public func add(tile: Tile) {
        grid[tile.position.row][tile.position.col] = tile
        movementCosts[tile.position.row][tile.position.col] = tile.movementCost
    }
    
    internal func add(city: City) {
        tile(at: city.position).add(city: city)
        cities.append(city)
    }
    
    public func tile(at: Position) -> Tile {       
        return grid[at.row][at.col]
    }
    
    public func revealAllTiles() {
        for row in 0..<height {
            for col in 0..<width {
                grid[row][col].set(visibility: Visibility.FullyRevealed)
            }
        }
    }
    
    public func canCreateCity(at: Position) -> Bool {
        if tile(at: at).terrain.type == TerrainType.Ocean {
            return false
        }
        
        if tile(at: at).visibility == Visibility.FogOfWar {
            return false
        }
        
        let startRow = at.row - 1 >= 0 ? at.row - 1 : 0
        let endRow = at.row + 1 <= height ? at.row + 1 : height
        let startCol = at.col - 1 >= 0 ? at.col - 1 : 0
        let endCol = at.col + 1 <= width ? at.col + 1 : width
        
        // Players cannot build cities adjacent to another city
        for row in startRow..<endRow {
            for col in startCol..<endCol {
                if tile(at: Position(row: row, col: col)).city != nil {
                    return false
                }
            }
        }
        
        return true
    }
    
    public func getDistanceToNearestCity(position: Position) -> Int {
        var minDistance = width + height
        
        if cities.count == 0 {
            return -1
        }
        
        for city in cities {
            let distanceToCity = city.position.distance(to: position)
            
            if distanceToCity < minDistance {
                minDistance = distanceToCity
            }
        }
        
        return minDistance
    }
        
//    public func add(player: Player) {
//        players.append(player)
//
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
//
//    }
    
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
    
    public func getFoodScoreMap() -> [[Double]] {
        var scoreMap = Array(repeating: Array(repeating: 0.0, count: width), count: height)
        
        for row in 0..<height {
            for col in 0..<width {
                scoreMap[row][col] = Double(grid[row][col].food)
            }
        }
        
        return scoreMap
    }
    
    public func getProductionScoreMap() -> [[Double]] {
        var scoreMap = Array(repeating: Array(repeating: 0.0, count: width), count: height)
        
        for row in 0..<height {
            for col in 0..<width {
                scoreMap[row][col] = Double(grid[row][col].production)
            }
        }
        
        return scoreMap
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
    
}
