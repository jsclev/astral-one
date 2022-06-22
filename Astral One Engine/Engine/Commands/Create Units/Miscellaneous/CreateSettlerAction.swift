import Foundation

public class CreateSettlerAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Create Settler", game: game, player: player)
        
        preconditions = []
        effects = []
        cost = 40
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var numTurns: Double {
        return Double(cost) / Double(city.getProductionPerTurn())
    }
    
    public override func execute() {
        let unit = Settler(game: game,
                            player: player,
                            theme: game.theme,
                            name: "Settler",
                            position: city.position)
        
        if city.has(building: BuildingType.Barracks) {
            unit.makeVeteran()
        }
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateSettlerAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}

public class CreateSettlerCommand: Command {
    public private(set) var settler: Settler?
    public let tile: Tile
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            cost: Int,
                            tile: Tile) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  cost: cost,
                  tile: tile)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                cost: Int,
                tile: Tile) {
        self.tile = tile
        
        super.init(commandId: commandId,
                   player: player,
                   type: CommandType(id: Constants.noId, name: ""),
                   turn: turn,
                   ordinal: ordinal,
                   cost: cost)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() -> CommandResult {
        let settler = Settler(game: player.game,
                              player: player,
                              theme: player.game.theme,
                              name: "Settler-\(Int.random(in: 0..<500))",
                              position: tile.position)
        
        player.add(cityCreator: settler)
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
