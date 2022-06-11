import Foundation
import Combine
import SpriteKit

public class UnitNode: SKSpriteNode {
    private let player: Player
    private let unit: Unit
    private let mapView: MapView
    
    private var cancellable = Set<AnyCancellable>()
    
    public override var isUserInteractionEnabled: Bool {
        set { }
        get { return true }
    }
    
    public init(player: Player, unit: Unit, mapView: MapView) {
        self.player = player
        self.unit = unit
        self.mapView = mapView
        
        let texture = SKTexture(imageNamed: unit.assetName)
        super.init(texture: texture, color: UIColor.systemPink, size: texture.size())
        
        self.name = "\(unit.name)_"
        
        self.unit.$position
            .dropFirst()
            .sink(receiveValue: { position in
                print("Moved unit [\(position.row),\(position.col)]")
                let point = self.mapView.getCenterPointOf(position: position)
                let moveAction = SKAction.move(to: point, duration: 0.60)
                
                self.run(moveAction, completion: {
                    if let turn = self.player.game.turns.last {
                        self.player.game.addCommand(command: NextTurnCommand(commandId: 1,
                                                                             player: Player(playerId: 1,
                                                                                            game: self.player.game,
                                                                                            map: self.player.map),
                                                                             type: CommandType.init(id: 1,
                                                                                                    name: "NextTurn"),
                                                                             turn: turn,
                                                                             ordinal: 1))
                        self.player.game.processCommands()
                        
                    }
                    
                })
            })
            .store(in: &cancellable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(unit.name), position [\(unit.position.row),\(unit.position.col)]")
        
        if unit.name == "Settler" {
            do {
                
                let agent = try SettlerAgent.getAgent(aiPlayer: player as! AIPlayer,
                                                      settler: unit as! Settler)
                if let position = try agent.getSettleCityPosition() {
                    print("Moving Settler to position [\(position.row), \(position.col)]")
                    let moveCmd = MoveUnitCommand(player: player,
                                                  type: CommandType(id: 1, name: ""),
                                                  turn: player.game.getCurrentTurn(),
                                                  ordinal: 1,
                                                  unit: unit,
                                                  to: position)
                    moveCmd.execute()
                    
                    let createCityCmd = CreateCityCommand(player: player,
                                                          type: CommandType(id: 0, name: ""),
                                                          turn: Turn(id: 1,
                                                                     year: -4000,
                                                                     ordinal: 1,
                                                                     displayText: "4000 B.C."),
                                                          ordinal: 1,
                                                          cost: 0,
                                                          cityCreator: unit as! CityCreator,
                                                          cityName: "New York")
                    createCityCmd.execute()
                }
            }
            catch {
                print(error)
            }
        }
    }
}
