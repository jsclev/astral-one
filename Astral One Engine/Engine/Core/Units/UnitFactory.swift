import Foundation

public class UnitFactory {
    public static func createUnit(game: Game, tiledId: Int, row: Int, col: Int) -> Unit {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        
        switch tiledId {
        case 1:
            return Infantry1(game: game,
                             player: Player(playerId: 1, game: game, name: "", map: map),
                             theme: theme,
                             name: "Warrior",
                             position: Position(row: row, col: col))
        case 25:
            return Cavalry7(game: game,
                            player: Player(playerId: 1, game: game, name: "",  map: map),
                            theme: theme,
                            name: "Tank",
                            position: Position(row: row, col: col))
        case 26:
            return Air1(game: game,
                        player: Player(playerId: 1, game: game, name: "",  map: map),
                        theme: theme,
                        name: "Battleship",
                        position: Position(row: row, col: col))
        case 27:
            return Infantry2(game: game,
                             player: Player(playerId: 1, game: game, name: "",  map: map),
                             theme: theme,
                             name: "Explorer",
                             position: Position(row: row, col: col))
        default:
            fatalError("Unable to create unit with Tiled Id \(tiledId).")
        }
    }
}
