import Foundation
import Combine
import CoreGraphics

public class Game: ObservableObject {
    @Published public var showFPS = false
    @Published public var numTaps = 0
    @Published public var tapLocation = CGPoint.zero
    @Published public var selectedMapPosition = MapPosition(row: -1, col: -1)
    @Published public var selectedCityCreator: CityCreator?
//    @Published public let tilesetName: String
    
    public var players: [Player] = []

    private var map: Map = Map(mapId: 1, width: 0, height: 0)
    public let db: Db

    public init(refreshDb: Bool) {
        self.db = Db(fullRefresh: refreshDb)
//        self.tilesetName = tilesetName
    }
    
    public func addPlayer(player: Player) {
        players.append(player)
    }
    
    public func getMap() -> Map {
        return map
    }
    
    public func importTiledMap(filename: String) throws {
        let tilesetParser = TiledTilesetParser(filename)
        let tileset = tilesetParser.parse()
        let mapParser = TiledMapParser(tiledTileset: tileset, filename: filename)
        
        // Import the Tiled map into the database
        let _ = try db.mapDao.insert(map: mapParser.parse())
        

    }
    
    public func load(gameId: Int) throws {
        // Pull the map from the database
        map = try db.mapDao.get(gameId: gameId)
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
