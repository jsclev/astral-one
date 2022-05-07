import Foundation
import GameplayKit

public class Unit: GKEntity, ObservableObject {
    public let theme: Theme
    public let playerId: Int
    public let tiledId: Int
    public let name: String
    public let assetName: String
    public let cost: Double
    public let maxHp: Double
    public var currentHp: Double
    public let attackRating: Double
    public let defenseRating: Double
    public let fp: Double
    public let maxMovementPoints: Double
    public var currentMovementPoints: Double
    @Published public var position: Position
    
    public init(theme: Theme,
                playerId: Int,
                tiledId: Int,
                name: String,
                assetName: String,
                cost: Double,
                maxHp: Double,
                attackRating: Double,
                defenseRating: Double,
                fp: Double,
                maxMovementPoints: Double,
                position: Position) {
        self.theme = theme
        self.playerId = playerId
        self.tiledId = tiledId
        self.name = name
        self.assetName = theme.name + "/" + assetName
        self.cost = cost
        self.maxHp = maxHp
        self.currentHp = maxHp
        self.attackRating = attackRating
        self.defenseRating = defenseRating
        self.fp = fp
        self.maxMovementPoints = maxMovementPoints
        self.currentMovementPoints = maxMovementPoints
        self.position = position
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func moveTo(position: Position) {
        self.position = position
    }
    
    public func getChebyshevDistance(toRow: Int, toCol: Int) -> Int {
        // This is also known as the "Chessboard distance"
        // See https://towardsdatascience.com/3-distances-that-every-data-scientist-should-know-59d864e5030a
        let xDistance = abs(toCol - position.col)
        let yDistance = abs(toRow - position.row)
        
        return max(xDistance, yDistance)
    }
    
    public func getChebyshevDistance(to: Unit) -> Int {
        // This is also known as the "Chessboard distance"
        // See https://towardsdatascience.com/3-distances-that-every-data-scientist-should-know-59d864e5030a
        let xDistance = abs(to.position.col - position.col)
        let yDistance = abs(to.position.row - position.row)
        
        return max(xDistance, yDistance)
    }
    
    public func getDiplomacyStatus(between: Unit) -> DiplomacyStatus {
        if playerId == between.playerId {
            return DiplomacyStatus.Same
        }
        
        return DiplomacyStatus.AtWar
    }
    
    public func getPathfindingGraph(map: Map) throws -> GridGraph {
        let graph = GridGraph(width: map.width, height: map.height)

        for mapRow in 0..<map.height {
            for mapCol in 0..<map.width {
                if mapRow == position.row && mapCol == position.col {
                    graph.add(node: ValueNode(row: mapRow, col: mapCol, value: 1.0))
                    continue
                }
                
                let tile = try map.tile(row: mapRow, col: mapCol)
                
                if tile.getUnits().count > 0 {
                    for unit in tile.getUnits() {
                        let calculator = UnitInfluenceMapCalculator(map: map,
                                                                    unit: unit,
                                                                    agent: self)
                        let unitMap = try calculator.getInfluenceMap()
                        
                        for threatRow in 0..<unitMap.count {
                            for threatCol in 0..<unitMap[threatRow].count {
                                if let gridGraphNode = graph.node(row: threatRow, col: threatCol) {
                                    gridGraphNode.add(value: unitMap[threatRow][threatCol])
                                }
                                else {
                                    graph.add(node: ValueNode(row: threatRow,
                                                                  col: threatCol,
                                                                  value: unitMap[threatRow][threatCol]))
                                }
                            }
                        }
                    }
                }
                else {
                    if let gridGraphNode = graph.node(row: mapRow, col: mapCol) {
                        gridGraphNode.add(value: 1.0)
                    }
                    else {
                        graph.add(node: ValueNode(row: mapRow, col: mapCol, value: 1.0))
                    }
                }
            }
        }
        
        return graph
    }
    
}
