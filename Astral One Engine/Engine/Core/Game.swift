import Foundation
import Combine

public class Game: ObservableObject {
    @Published public var showFPS = false

    private var map: Map = Map(mapId: 1, width: 0, height: 0)
    public let db: Db

    public init(db: Db) {
        self.db = db
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
        
        // Pull the map from the database
        map = try db.mapDao.get(mapId: 1)
    }
    
    public func processCommands(commands: [Command]) {
        for command in commands {
            print(command)
            command.execute()
        }
    }
}

extension ObservableObject where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
    func registerNestedObservableObject<Object: ObservableObject>(_ vm: Object,
                                                                  cancellables: inout [AnyCancellable]) {
        cancellables.append(
            vm.objectWillChange.sink { [weak self] _ in
                self?.objectWillChange.send()
            }
        )
    }
    func registerNestedObservableObject<Object: ObservableObject>(_ vm: Object,
                                                                  cancellable: inout AnyCancellable?) {
        cancellable = vm.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
}

