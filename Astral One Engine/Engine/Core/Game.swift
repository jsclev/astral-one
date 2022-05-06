import Foundation
import Combine
import CoreGraphics

public class Game: ObservableObject {
    @Published public var showFPS = false
    @Published public var numTaps = 0
    @Published public var tapLocation = CGPoint.zero
    @Published public var selectedMapPosition = MapPosition(row: -1, col: -1)
    @Published public var selectedCityCreator: CityCreator?
    
    public var players: [Player] = []
    public var map: Map = Map(mapId: 1, width: 0, height: 0)
    public let theme: Theme

    public init(theme: Theme) {
        self.theme = theme
    }
    
    public func addPlayer(player: Player) {
        players.append(player)
    }
    
    public func processCommands(commands: [Command]) {
        for command in commands {
            print(command)
            command.execute()
        }
    }
    
    public func selectMapPosition(mapPosition: MapPosition) {
        self.selectedMapPosition = mapPosition
    }
}
