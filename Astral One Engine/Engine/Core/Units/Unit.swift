import Foundation
import GameplayKit
import SpriteKit

public class Unit: ObservableObject, Equatable {
    public let id: Int
    public let player: Player
    public let theme: Theme
    public let tiledId: Int
    public let name: String
    public let assetName: String
    public let cost: Double
    public let maxHp: Double
    public var currentHp: Double
    public private(set) var attack: Double
    public private(set) var defense: Double
    public private(set) var isVeteran = false
    public private(set) var isFortified = false
    public let fp: Double
    public let maxMovementPoints: Double
    public var movementPoints: Double
    @Published public var position: Position
    @Published public var availableCommands: [Command] = []
    @Published public var homeCity: City?
    public var node: SKNode?
    
    public init(id: Int,
                player: Player,
                theme: Theme,
                tiledId: Int,
                name: String,
                assetName: String,
                cost: Double,
                maxHp: Double,
                attack: Double,
                defense: Double,
                fp: Double,
                maxMovementPoints: Double,
                position: Position) {
        self.id = id
        self.theme = theme
        self.player = player
        self.tiledId = tiledId
        self.name = name
        self.assetName = assetName
        self.cost = cost
        self.maxHp = maxHp
        self.currentHp = maxHp
        self.attack = attack
        self.defense = defense
        self.fp = fp
        self.maxMovementPoints = maxMovementPoints
        self.movementPoints = maxMovementPoints
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func == (lhs: Unit, rhs: Unit) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var city: City? {
        return player.map.tile(at: position).city
    }
    
    public var defenseAgainstGroundAttacks: Double {
        if let city = city {
            if city.has(building: BuildingType.CityWalls) {
                return 3.0 * defense
            }
        }
        
        return defense
    }
    
    public func defense(against: Unit) -> Double {
        var calculatedDefense = defense
        
        if isVeteran {
            calculatedDefense = defense * 1.5
        }
        
        calculatedDefense *= player.map.tile(at: position).defenseBonus
        
        return floor(calculatedDefense)
    }
    
    internal func move(to: Position) {
        fatalError("move(to:) must be implemented by a subclass.")
    }
    
    public func canMove(to: Position) -> Bool {
        fatalError("canMove(to:) must be implemented by a subclass.")
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
        if player.playerId == between.player.playerId {
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
                
                //                let tile = try map.tile(row: mapRow, col: mapCol)
                
                //                if tile.getUnits().count > 0 {
                //                    for unit in tile.getUnits() {
                //                        let calculator = UnitInfluenceMapCalculator(map: map,
                //                                                                    unit: unit,
                //                                                                    agent: self)
                //                        let unitMap = try calculator.getInfluenceMap()
                //
                //                        for threatRow in 0..<unitMap.count {
                //                            for threatCol in 0..<unitMap[threatRow].count {
                //                                if let gridGraphNode = graph.node(row: threatRow, col: threatCol) {
                //                                    gridGraphNode.add(value: unitMap[threatRow][threatCol])
                //                                }
                //                                else {
                //                                    graph.add(node: ValueNode(row: threatRow,
                //                                                                  col: threatCol,
                //                                                                  value: unitMap[threatRow][threatCol]))
                //                                }
                //                            }
                //                        }
                //                    }
                //                }
                //                else {
                //                    if let gridGraphNode = graph.node(row: mapRow, col: mapCol) {
                //                        gridGraphNode.add(value: 1.0)
                //                    }
                //                    else {
                //                        graph.add(node: ValueNode(row: mapRow, col: mapCol, value: 1.0))
                //                    }
                //                }
            }
        }
        
        return graph
    }
    
    public func isInCity() -> Bool {
        return city == nil
    }
    
    public var defenseVsGroundAttacks: Double {
        //        let groundUnits = ["Warrior", "Phalanx", "Horseman", "Archer", "Pikeman"]
        if let city = player.getCity(at: position) {
            if city.has(building: BuildingType.CityWalls) {
                return 3.0 * defense
            }
        }
        
        return defense
    }
    
    public func makeVeteran() {
        isVeteran = true
    }
    
//    public var movementMap: [[Bool]] {
//        var movesLeft = true
//        var startPosition = position
//        var movementMap: [[Double]] = Array(repeating: Array(repeating: -1.0,
//                                                             count: player.map.width),
//                                            count: player.map.height)
//
//        while movesLeft {
//            let startRow = startPosition.row - 1
//            let endRow = startPosition.row + 2
//            let startCol = startPosition.col - 1
//            let endCol = startPosition.col + 2
//
//            for row in startRow..<endRow {
//                for col in startCol..<endCol {
//
//                }
//            }
//        }
//    }
    
    public func clone() -> Unit {
        fatalError("clone() must be implemented in subclasses.")
    }
    
}
