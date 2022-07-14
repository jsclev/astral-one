import Foundation

public class CityAgent {
    internal let player: AIPlayer
    internal let city: City
    
    public init(player: AIPlayer, city: City) throws {
        self.player = player
        self.city = city
    }
    
    public static func getAgent(aiPlayer: AIPlayer, city: City) throws -> CityAgent {
        switch aiPlayer.skillLevel {
        case .One:
            return try CityLevel1Agent(player: aiPlayer, city: city)
        case .Two:
            return try CityLevel1Agent(player: aiPlayer, city: city)
        case .Three:
            return try CityLevel1Agent(player: aiPlayer, city: city)
        case .Four:
            return try CityLevel1Agent(player: aiPlayer, city: city)
        case .Five:
            return try CityLevel1Agent(player: aiPlayer, city: city)
        case .Six:
            return try CityLevel1Agent(player: aiPlayer, city: city)
        case .Seven:
            return try CityLevel1Agent(player: aiPlayer, city: city)
        case .Eight:
            return try CityLevel8Agent(player: aiPlayer, city: city)
        }
    }
    
    public func getNextCommand() -> Command {
        fatalError("Must be implemented in subclasses.")
    }
    
    public var availableCommands: [Command] {
        var commands: [Command] = []
        commands.append(CreateInfantry1Command(player: player,
                                               turn: player.game.getCurrentTurn(),
                                               ordinal: player.game.getCurrentTurn().ordinal,
                                               cost: 1,
                                               city: city))
        commands.append(CreateSettlerCommand(player: player,
                                             turn: player.game.getCurrentTurn(),
                                             ordinal: player.game.getCurrentTurn().ordinal,
                                             cost: 1,
                                             tile: player.map.tile(at: city.position)))
        if player.hasResearched(advanceName: "Bronze Working") {
            commands.append(CreateInfantry2Command(player: player,
                                                   turn: player.game.getCurrentTurn(),
                                                   ordinal: player.game.getCurrentTurn().ordinal,
                                                   cost: 1,
                                                   city: city))
        }
        if player.hasResearched(advanceName: "Warrior Code") {
            commands.append(CreateInfantry3Command(player: player,
                                                   turn: player.game.getCurrentTurn(),
                                                   ordinal: player.game.getCurrentTurn().ordinal,
                                                   cost: 1,
                                                   city: city))
        }
        if player.hasResearched(advanceName: "Feudalism") {
            commands.append(CreateInfantry4Command(player: player,
                                                   turn: player.game.getCurrentTurn(),
                                                   ordinal: player.game.getCurrentTurn().ordinal,
                                                   cost: 1,
                                                   city: city))
        }
        if !city.has(building: BuildingType.Barracks) {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: player.game.getCurrentTurn(),
                                                 ordinal: player.game.getCurrentTurn().ordinal,
                                                 cost: 1,
                                                 city: city,
                                                 buildingType: BuildingType.Barracks))
        }
        
        if player.hasResearched(advanceName: "Map Making") &&
            city.canBuild(building: BuildingType.Lighthouse) {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: player.game.getCurrentTurn(),
                                                 ordinal: player.game.getCurrentTurn().ordinal,
                                                 cost: 1,
                                                 city: city,
                                                 buildingType: BuildingType.Lighthouse))
        }
        
        // FIXME: Need to add check for Seafaring advance
        if player.hasResearched(advanceName: "Seafaring") &&
            city.canBuild(building: BuildingType.Harbor) {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: player.game.getCurrentTurn(),
                                                 ordinal: player.game.getCurrentTurn().ordinal,
                                                 cost: 1,
                                                 city: city,
                                                 buildingType: BuildingType.Harbor))
        }
        
        // FIXME: Need to add availability for the other littoral improvements:
        //        Coastal Fortress, Offshore Platform, and Port Facility
        
        if !city.has(building: BuildingType.Granary) &&
            player.hasResearched(advanceName: "Alphabet") {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: player.game.getCurrentTurn(),
                                                 ordinal: player.game.getCurrentTurn().ordinal,
                                                 cost: 1,
                                                 city: city,
                                                 buildingType: BuildingType.Granary))
        }
        
        if !city.has(building: BuildingType.Temple) &&
            player.hasResearched(advanceName: "Ceremonial Burial") {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: player.game.getCurrentTurn(),
                                                 ordinal: player.game.getCurrentTurn().ordinal,
                                                 cost: 1,
                                                 city: city,
                                                 buildingType: BuildingType.Temple))
        }
        
        if !city.has(building: BuildingType.CityWalls) &&
            player.hasResearched(advanceName: "Masonry") {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: player.game.getCurrentTurn(),
                                                 ordinal: 1,
                                                 cost: 1,
                                                 city: city,
                                                 buildingType: BuildingType.CityWalls))
        }
        
        return commands
    }
}
