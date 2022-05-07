import Foundation

public class UnitFactory {
    public static func createUnit(tiledId: Int, row: Int, col: Int) -> Unit {
        switch tiledId {
        case 1:
            return Infantry1(theme: Theme(id: 1, name: "Standard"),
                             playerId: 1,
                             name: "Warrior",
                             position: Position(row: row, col: col))
        case 25:
            return Cavalry7(theme: Theme(id: 1, name: "Standard"),
                            playerId: 1,
                            name: "Tank",
                            position: Position(row: row, col: col))
        case 26:
            return Air1(theme: Theme(id: 1, name: "Standard"),
                        playerId: 1,
                        name: "Battleship",
                        position: Position(row: row, col: col))
        case 27:
            return Infantry2(theme: Theme(id: 1, name: "Standard"),
                             playerId: 1,
                             name: "Explorer",
                             position: Position(row: row, col: col))
        default:
            fatalError("Unable to create unit with Tiled Id \(tiledId).")
        }
    }
}
