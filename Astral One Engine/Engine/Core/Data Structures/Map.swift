import Foundation
import GameplayKit

public class Map {
    private let graph: GridGraph
    private var movementCosts: [[Float]] = [[]]
    private var unitType: UnitType = UnitType.Explorer
    
    public var width: Int {
        graph.width
    }
    
    public var height: Int {
        graph.height
    }
    
    public init(width: Int32, height: Int32) {
        graph = GridGraph(width: Int(width), height: Int(height))
        movementCosts = Array(repeating: Array(repeating: 0.0, count: self.width), count: self.height)
    }
    
    public func setUnitType(unitType: UnitType) {
        self.unitType = unitType
    }
    
    public func getNode(row: Int, col: Int) -> Node? {
        return graph.node(row: row, col: col)
    }
    
    public func getTiles(row: Int, col: Int) -> [Tile] {
        if let node = getNode(row: row, col: col) {
            return node.getTiles()
        }
        
        return []
    }
    
    public func getMovementCosts() -> [[Float]] {
        return movementCosts
    }
    
    public func addTile(row: Int, col: Int, tile: Tile) {
        if let node = graph.node(row: row, col: col) {
            node.addTile(tile: Tile(id: tile.id,
                                    spec: tile.spec,
                                    ordinal: node.getTiles().count))
            
        }
        else {
            let node = Node(row: row, col: col)
            node.addTile(tile: Tile(id: tile.id,
                                    spec: tile.spec,
                                    ordinal: node.getTiles().count))
            graph.add(node: node)
        }
        
        if tile.spec.terrainType == TerrainType.Desert {
            movementCosts[row][col] += 1.0
        }
        else if tile.spec.terrainType == TerrainType.Forest {
            movementCosts[row][col] += 2.0
        }
        else if tile.spec.terrainType == TerrainType.Grassland {
            movementCosts[row][col] += 1.0
        }
        else if tile.spec.terrainType == TerrainType.Hills {
            movementCosts[row][col] += 2.0
        }
        else if tile.spec.terrainType == TerrainType.Jungle {
            movementCosts[row][col] += 2.0
        }
        else if tile.spec.terrainType == TerrainType.Mountains {
            movementCosts[row][col] += 3.0
        }
        else if tile.spec.terrainType == TerrainType.Plains {
            movementCosts[row][col] += 1.0
        }
        else if tile.spec.terrainType == TerrainType.Tundra {
            movementCosts[row][col] += 1.0
        }
        else if tile.spec.terrainType == TerrainType.Water {
            movementCosts[row][col] += 1.0
        }
    }
    
    public func getNumLayers() -> Int {
        var numLayers: Int = 0
        for row in 0..<width {
            for col in 0..<height {
                if let node = graph.node(row: row, col: col) {
                    let myLayerCount = node.getTiles().count
                    if myLayerCount > numLayers {
                        numLayers = myLayerCount
                    }
                }
            }
        }

        return numLayers
    }
    
    public func findPath(from: SIMD2<Int32>, to: SIMD2<Int32>) -> [GKGraphNode] {
//        let startNode = graph.node(row: Int(from.y), col: Int(from.x))
//        let endNode = graph.node(row: Int(to.y), col: Int(to.x))
//        if let startNode = startNode, let endNode = endNode {
//            return graph.findPath(from: startNode, to: endNode)
//        }
        
        return []
    }
    
    public func log() {
        print("****************************************************************")
        print("Map dimensions: [\(graph.width), \(graph.height)]")
        
        for row in 0..<width {
            for col in 0..<height {
                if let node = graph.node(row: row, col: col) {
                    print("Node [\(row),\(col)]: \(node.getTiles().count) tiles.")
//                    for tile in node.getTiles() {
//                        if let tileType = Constants.tiles[tile.id] {
//                            if let tileGroup = tileset.tileGroups.first(where: { $0.name == tileType }) {
//                                unitsMap.setTileGroup(tileGroup, forColumn: col, row: row)
//                            }
//                        }
//                    }
                }
            }
        }
        
        print("****************************************************************")
    }
    
    public func getUnit() -> Unit? {
        for row in 0..<width {
            for col in 0..<height {
                if let node = graph.node(row: row, col: col) {
                    let tiles = node.getTiles()
                    
                    for tile in tiles {
                        if tile.spec.tileType == TileType.Unit {
                            return Infantry1(playerId: 1,
                                               name: "Warrior",
                                               row: 0,
                                               col: 0)
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    public func getDistance(fromRow: Int, fromCol: Int, toRow: Int, toCol: Int) -> Int {
        return abs(toRow - fromRow) + abs(toCol - fromCol) + 1
    }
}
