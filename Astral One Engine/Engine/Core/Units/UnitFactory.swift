import Foundation

public class UnitFactory {
    public static func createUnit(game: Game, tiledId: Int, row: Int, col: Int) -> Unit {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let player = Player(playerId: 1, name: "", ordinal: 1, map: map)
        let position = Position(row: row, col: col)
        
        switch tiledId {
        case 1:
            return Infantry1(player: player,
                             theme: theme,
                             name: "Warrior",
                             position: position)
        case 25:
            return Cavalry7(player: player,
                            theme: theme,
                            name: "Tank",
                            position: position)
        case 26:
            return Air1(player: player,
                        theme: theme,
                        name: "Battleship",
                        position: position)
        case 27:
            return Infantry2(player: player,
                             theme: theme,
                             name: "Explorer",
                             position: position)
        default:
            fatalError("Unable to create unit with Tiled Id \(tiledId).")
        }
    }
}
