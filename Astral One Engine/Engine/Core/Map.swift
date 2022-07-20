import Foundation
import GameplayKit
import Combine

public class Map: ObservableObject {
    public let mapId: Int
    public let width: Int
    public let height: Int
    private var grid: [[Tile]]
    private var myMovementCosts: [[Double]]
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
                                  type: TerrainType.Glacier)
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
                                                            type: TerrainType.Glacier),
                                                            hasRiver: false)
            }
        }
        
        self.myMovementCosts = Array(repeating: Array(repeating:0.0, count: width), count: height)
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
        myMovementCosts[tile.position.row][tile.position.col] = tile.movementCost
    }
    
    internal func add(city: City) {
        tile(at: city.position).add(city: city)
        cities.append(city)
    }
    
    public func tile(at: Position) -> Tile {       
        return grid[at.row][at.col]
    }
    
    public func accessToOcean(tile: Tile) -> Bool {
        // FIXME: Need to account for landlocked water tiles (lakes)
        let startRow = tile.position.row == 0 ? 0 : tile.position.row - 1
        let endRow = tile.position.row == height - 1 ? tile.position.row : tile.position.row + 1
        let startCol = tile.position.col == 0 ? 0 : tile.position.col - 1
        let endCol = tile.position.col == width - 1 ? tile.position.col : tile.position.col + 1
        
        for row in startRow..<endRow {
            for col in startCol..<endCol {
                if grid[row][col].terrain.type == TerrainType.Ocean {
                    return true
                }
            }
        }
        
        return false
    }
    
    public func revealAllTiles() {
        for row in 0..<height {
            for col in 0..<width {
                grid[row][col].set(visibility: Visibility.FullyRevealed)
            }
        }
    }
    
    public func canCreateCity(at: Position) -> Bool {
        if tile(at: at).terrain.type == TerrainType.Ocean ||
           tile(at: at).terrain.type == TerrainType.Glacier {
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
    
    public func getTilesInCityRadius(from: Position) -> [Tile] {
        var cityRadiusTiles: [Tile] = []
        var positions: [Position] = []
        
        let startRow = from.row - 2
        let endRow = from.row + 2
        let startCol = from.col - 2
        let endCol = from.col + 2
        
        for row in startRow...endRow {
            for col in startCol...endCol {
                // We don't add the outer corners in the city radius
                if row == startRow && col == startCol ||
                    row == endRow && col == startCol ||
                    row == startRow && col == endCol ||
                    row == endRow && col == endCol {
                    continue
                }
                else {
                    positions.append(Position(row: row, col: col))
                }
            }
        }
        
        positions = positions.filter{
            $0.row >= 0 &&
            $0.row < height &&
            $0.col >= 0 &&
            $0.col < width
        }
        
        for position in positions {
            cityRadiusTiles.append(tile(at: position))
        }
        
        return cityRadiusTiles
    }
    
    public func getGrid() -> [[Tile]] {
        return grid
    }
    
    public func getUnits(row: Int, col: Int) -> [Unit] {
        return []
//        return grid[row][col].getUnits()
    }
    
    public var movementCosts: [[Double]] {
        return myMovementCosts
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
