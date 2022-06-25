import GameplayKit
import SwiftUI

public class Explorer: Unit {
    public convenience init(game: Game,
                            player: Player,
                            theme: Theme,
                            name: String,
                            position: Position) {
        self.init(id: Constants.noId,
                  game: game,
                  player: player,
                  theme: theme,
                  name: name,
                  position: position)
    }
    
    public init(id: Int,
                game: Game,
                player: Player,
                theme: Theme,
                name: String,
                position: Position) {
        super.init(id: id,
                   game: game,
                   player: player,
                   theme: theme,
                   tiledId: 100,
                   name: name,
                   assetName: "Units/Misc/explorer",
                   cost: 10,
                   maxHp: 10,
                   attack: 1,
                   defense: 1,
                   fp: 1,
                   maxMovementPoints: 1.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func clone() -> Unit {
        return Explorer(game: game,
                         player: player,
                         theme: theme,
                         name: name,
                         position: position)
    }
}

//public class ExplorerOld: Unit {
//    private let game: Game
//    private var position: SIMD2<Int32>
//
//    public init(theme: Theme,
//                game: Game,
//                position: SIMD2<Int32>) {
//        self.game = game
//        self.position = position
//
//        super.init(theme: theme,
//                   playerId: 1,
//                   tiledId: 27,
//                   name: "Explorer",
//                   assetName: "explorer",
//                   cost: 10,
//                   maxHp: 10,
//                   attack: 1,
//                   defense: 1,
//                   fp: 1,
//                   maxMovementPoints: 1.0,
//                   row: Int(position.y),
//                   col: Int(position.x))
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func add<NodeType>(node: NodeType, to graph: GKGridGraph<NodeType>) {
//
//        // If there's a node at this position here already, remove it
//        if let existingNode = graph.node(atGridPosition: node.gridPosition) {
//            graph.remove([existingNode])
//        }
//
//        // Add the new node, and connect it to the other nodes on the graph
//        graph.connectToAdjacentNodes(node: node)
//    }
//
////    public func getPath(to: SIMD2<Int32>) -> [GKGraphNode] {
////        let graph = GKGridGraph<ExplorerNode>(fromGridStartingAt: SIMD2<Int32>(0, 0),
////                                              width: Int32(game.getMap().width),
////                                              height: Int32(game.getMap().height),
////                                              diagonalsAllowed: true)
//////        let graph = GKGridGraph<ExplorerNode>()
//////        var nodes: [ExplorerNode] = []
////        for row in 0..<game.getMap().height {
////            for col in 0..<game.getMap().width {
////                let gridPosition = SIMD2<Int32>(Int32(row), Int32(col))
////
////                if let mapNode = game.getMap().getNode(row: row, col: col) {
////                    let tiles = mapNode.getTiles()
////
////                    if tiles.count > 0 &&
////                        (tiles[0].spec.terrainType == TerrainType.Water ||
////                         tiles[0].spec.terrainType == TerrainType.Glacier) {
////                        nodesToRemove.append(localNode)
////                        graph.remove([localNode])
////                    }
////                    else {
////                        let localNode = ExplorerNode(gridPosition: gridPosition)
////                        localNode.setMap(map: game.getMap())
////                        nodes.append(localNode)
////                        add(node: localNode, to: graph)
////                    }
////                }
////            }
////        }
//
////        graph.add(nodes)
////
////        for node in nodes {
////            var connectedNodes: [ExplorerNode] = []
////            print(node.gridPosition)
////
////            int idx = (position.y - self.gridOrigin.y) * (int)self.gridWidth + (position.x - self.gridOrigin.x);
////            return self.gridNodes[idx];
////
////            let nPosition = SIMD2<Int32>(Int32(node.gridPosition.x), Int32(node.gridPosition.y - 1))
////            if let north = graph.node(atGridPosition: nPosition) {
////                connectedNodes.append(north)
////            }
////
////            let nePosition = SIMD2<Int32>(Int32(node.gridPosition.x + 1), Int32(node.gridPosition.y - 1))
////            if let northeast = graph.node(atGridPosition: nePosition) {
////                connectedNodes.append(northeast)
////            }
////
////            let ePosition = SIMD2<Int32>(Int32(node.gridPosition.x + 1), Int32(node.gridPosition.y))
////            if let east = graph.node(atGridPosition: ePosition) {
////                connectedNodes.append(east)
////            }
////
////            let sePosition = SIMD2<Int32>(Int32(node.gridPosition.x + 1), Int32(node.gridPosition.y + 1))
////            if let southeast = graph.node(atGridPosition: sePosition) {
////                connectedNodes.append(southeast)
////            }
////
////            let sPosition = SIMD2<Int32>(Int32(node.gridPosition.x), Int32(node.gridPosition.y + 1))
////            if let south = graph.node(atGridPosition: sPosition) {
////                connectedNodes.append(south)
////            }
////
////            node.addConnections(to: connectedNodes, bidirectional: true)
////        }
//
//        // Prune non-traversable nodes
////        var nodesToRemove: [ExplorerNode] = []
////        for row in 0..<graph.gridHeight {
////            for col in 0..<graph.gridWidth {
////                let gridPosition = SIMD2<Int32>(Int32(row), Int32(col))
////
////                if let mapNode = game.map.getNode(row: row, col: col),
////                   let localNode = graph.node(atGridPosition: gridPosition) {
////                    let tiles = mapNode.getTiles()
////
////                    if tiles.count > 0 &&
////                        (tiles[0].spec.terrainType == TerrainType.Water ||
////                         tiles[0].spec.terrainType == TerrainType.Glacier) {
//////                        print("Removing water or glacier node at [\(gridPosition)].")
////                        nodesToRemove.append(localNode)
//////                        graph.remove([localNode])
////                    }
////                    else {
////                        localNode.setMap(map: game.map)
////                    }
////                }
////            }
////        }
////
////        graph.remove(nodesToRemove)
//
////        if let fromNode = graph.node(atGridPosition: position),
////           let toNode = graph.node(atGridPosition: to){
////            var path: [GKGridGraphNode] = []
////
////            let localPath = graph.findPath(from: fromNode, to: toNode)
////
////            for aNode in localPath as! [GKGridGraphNode] {
////                path.append(aNode)
////            }
////
////            return path
////        }
////
////        return []
////    }
//}

public class ExplorerNode: GKGridGraphNode {
    private var map: Map = Map(mapId: 1, width: 0, height: 0)
    private var enemyHP: Float = 0.0
    private var enemyLandAttack: Float = 0.0
    private var enemyLandDefense: Float = 0.0
    private var avgEnemyMovement: Float = 0.0
    
    override init(gridPosition: vector_int2) {
        super.init(gridPosition: gridPosition)
    }
    
    public func setMap(map: Map) {
        self.map = map
    }
    
    public func getEnemyLandAttack() -> Float {
        return enemyLandAttack
    }
    
    public func getEnemyLandDefense() -> Float {
        return enemyLandDefense
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}
