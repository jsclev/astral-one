import Foundation
import Combine
import CoreGraphics

public class Game: ObservableObject {
    @Published public var showFPS = false
    @Published public var numTaps = 0
    @Published public var tapLocation = CGPoint.zero
    @Published public var selectedMapPosition = MapPosition(row: -1, col: -1)

    private var map: Map = Map(mapId: 1, width: 0, height: 0)
    public let db: Db

    public init(refreshDb: Bool) {
        self.db = Db(fullRefresh: refreshDb)
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

//extension ObservableObject where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
//    func registerNestedObservableObject<Object: ObservableObject>(_ vm: Object,
//                                                                  cancellables: inout [AnyCancellable]) {
//        cancellables.append(
//            vm.objectWillChange.sink { [weak self] _ in
//                self?.objectWillChange.send()
//            }
//        )
//    }
//    func registerNestedObservableObject<Object: ObservableObject>(_ vm: Object,
//                                                                  cancellable: inout AnyCancellable?) {
//        cancellable = vm.objectWillChange.sink { [weak self] _ in
//            self?.objectWillChange.send()
//        }
//    }
//}

