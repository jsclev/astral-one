import Foundation

public class CityAgent {
    internal let game: Game
    internal let player: Player
    internal let city: City
    
    public init(game: Game, player: Player, city: City) throws {
        self.game = game
        self.player = player
        self.city = city
    }
    
    public static func getAgent(game: Game, player: Player, city: City) throws -> CityAgent {
        switch player.skillLevel {
        case .One:
            return try CityLevel1Agent(game: game, player: player, city: city)
        case .Two:
            return try CityLevel1Agent(game: game, player: player, city: city)
        case .Three:
            return try CityLevel1Agent(game: game, player: player, city: city)
        case .Four:
            return try CityLevel1Agent(game: game, player: player, city: city)
        case .Five:
            return try CityLevel1Agent(game: game, player: player, city: city)
        case .Six:
            return try CityLevel1Agent(game: game, player: player, city: city)
        case .Seven:
            return try CityLevel1Agent(game: game, player: player, city: city)
        case .Eight:
            return try CityLevel8Agent(game: game, player: player, city: city)
        }
    }
    
    public func getNextCommand() -> Command {
        fatalError("Must be implemented in subclasses.")
    }
    
    public var availableCommands: [Command] {
        var commands: [Command] = []
        commands.append(CreateInfantry1Command(db: game.db,
                                               player: player,
                                               turn: game.currentTurn,
                                               city: city))
        commands.append(CreateSettlerCommand(db: game.db,
                                             player: player,
                                             turn: game.currentTurn,
                                             tile: player.map.tile(at: city.position)))
        if player.hasResearched(advanceName: "Bronze Working") {
            commands.append(CreateInfantry2Command(player: player,
                                                   turn: game.currentTurn,
                                                   city: city))
        }
        if player.hasResearched(advanceName: "Warrior Code") {
            commands.append(CreateInfantry3Command(player: player,
                                                   turn: game.currentTurn,
                                                   city: city))
        }
        if player.hasResearched(advanceName: "Feudalism") {
            commands.append(CreateInfantry4Command(player: player,
                                                   turn: game.currentTurn,
                                                   city: city))
        }
        if !city.has(building: BuildingType.Barracks) {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: game.currentTurn,
                                                 city: city,
                                                 buildingType: BuildingType.Barracks))
        }
        
        if player.hasResearched(advanceName: "Map Making") &&
            city.canBuild(building: BuildingType.Lighthouse) {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: game.currentTurn,
                                                 city: city,
                                                 buildingType: BuildingType.Lighthouse))
        }
        
        // FIXME: Need to add check for Seafaring advance
        if player.hasResearched(advanceName: "Seafaring") &&
            city.canBuild(building: BuildingType.Harbor) {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: game.currentTurn,
                                                 city: city,
                                                 buildingType: BuildingType.Harbor))
        }
        
        // FIXME: Need to add availability for the other littoral improvements:
        //        Coastal Fortress, Offshore Platform, and Port Facility
        
        if !city.has(building: BuildingType.Granary) &&
            player.hasResearched(advanceName: "Alphabet") {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: game.currentTurn,
                                                 city: city,
                                                 buildingType: BuildingType.Granary))
        }
        
        if !city.has(building: BuildingType.Temple) &&
            player.hasResearched(advanceName: "Ceremonial Burial") {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: game.currentTurn,
                                                 city: city,
                                                 buildingType: BuildingType.Temple))
        }
        
        if !city.has(building: BuildingType.CityWalls) &&
            player.hasResearched(advanceName: "Masonry") {
            commands.append(BuildBuildingCommand(player: player,
                                                 turn: game.currentTurn,
                                                 city: city,
                                                 buildingType: BuildingType.CityWalls))
        }
        
        return commands
    }
}
