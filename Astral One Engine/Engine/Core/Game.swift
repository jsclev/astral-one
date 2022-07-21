import Foundation
import Combine
import CoreGraphics

public class Game: ObservableObject {
    @Published public var showFPS = false
    @Published public var numTaps = 0
    @Published public var tapLocation = CGPoint.zero
    @Published public var selectedMapPosition = Position(row: -1, col: -1)
    @Published public var selectedCityCreator: Settler?
    @Published public private (set) var currentPlayer: Player
    @Published public var turnIndex = 0
    @Published public var tileCoords = false
    @Published public var aiDebug = false

    public let gameId: Int
    public let turns: [Turn]
    public let players: [Player]
    public let map: Map
    public let theme: Theme
    public var commands: [Command] = []
    public let db: Db
    public var canvasSize = CGSize.zero
    public private (set) var currentPlayerIndex = 0
    private var cancellable = Set<AnyCancellable>()
    
    public init(gameId: Int,
                theme: Theme,
                players: [Player],
                map: Map,
                db: Db) throws {
        self.gameId = gameId
        self.theme = theme
        self.map = map
        self.db = db
        self.turns = try self.db.turnDao.getTurns(theme: theme)
        self.currentPlayerIndex = 0
        self.players = players
        self.currentPlayer = players[0]
        
        for player in players {
            player.$turnStatus
                .dropFirst()
                .sink(receiveValue: { turnStatus in
                    if turnStatus == 1 {
                        self.bumpPlayerTurn()
                    }
                })
                .store(in: &cancellable)
            
            player.$cityCreators
                .sink(receiveValue: { cityCreators in
                    for playerToUpdate in self.players {
                        if playerToUpdate != player {
                            for cityCreator in cityCreators {
                                playerToUpdate.addOther(cityCreator: cityCreator)
                                //print("City creator at \(cityCreator.position)")
//                                let tile = playerToUpdate.map.tile(at: cityCreator.position)
//
//                                if tile.visibility == Visibility.FullyRevealed {
//                                    tile.a
//                                }
                            }
//                            print("Need to update the map")
                        }
                    }
//                    if cityCreators.count < self.localSettlers.count {
//                        for settler in self.localSettlers {
//                            var foundIt = false
//                            for diff in cityCreators {
//                                if diff.name == settler.name {
//                                    foundIt = true
//                                }
//                            }
//
//                            if !foundIt {
//                                self.localSettlers.remove(at: self.localSettlers.count - 1)
//
//                                if let node = self.scene.childNode(withName: settler.name) {
//                                    node.removeFromParent()
//                                }
//                            }
//                        }
//                    }
//                    else {
//                        if let cityCreator = cityCreators.last {
//                            self.renderUnit(unit: cityCreator)
//                            self.localSettlers.append(cityCreator as! Settler)
//                        }
//                    }
                })
                .store(in: &cancellable)
        }
    }
    
    public func addCommand(command: Command) {
        commands.append(command)
    }
    
    public func bumpPlayerTurn() {
        if currentPlayerIndex == players.count - 1 {
            currentPlayerIndex = 0
            
            if turnIndex < turns.count {
                turnIndex += 1
            }
            
            for player in players {
                for cityCreator in player.cityCreators {
                    cityCreator.movementPoints = cityCreator.maxMovementPoints
                }
                
                for unit in player.units {
                    unit.movementPoints = unit.maxMovementPoints
                }
            }
        }
        else {
            currentPlayerIndex += 1
        }
        
        currentPlayer = players[currentPlayerIndex]
    }
    
    public var currentTurn: Turn {
        return turns[turnIndex]
    }
    
    public func processCommands() {
        while !commands.isEmpty {
            let _ = commands.removeLast().execute()
        }
    }
    
    public func select(mapPosition: Position) {
        self.selectedMapPosition = mapPosition
    }
    
    public func toggleTileCoords() {
        tileCoords = !tileCoords
    }
    
    public func toggleAIDebug() {
        aiDebug = !aiDebug
    }
}
