import Foundation
import Combine

public class Game: ObservableObject {
    @Published public var showFPS = false

    private var map: Map = Map(width: 0, height: 0)
    public let db = Db(fullRefresh: true)
    private var commands: [Command] = []

    public init() {
        
    }
    
    public func getMap() -> Map {
        return map
    }
    
    public func importTiledMap(filename: String) {
        let tilesetParser = TiledTilesetParser(filename)
        let tileset = tilesetParser.parse()
        let mapParser = TiledMapParser(tiledTileset: tileset, filename: filename)
        
        map = mapParser.parse()
    }
    
    public func prune() {
        map.prune()
    }
    
    public func addCommand(command: Command) {
        commands.append(command)
    }
    
    public func processCommands() {
        for command in commands {
            command.execute()
        }
    }
}

extension ObservableObject where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
    func registerNestedObservableObject<Object: ObservableObject>(_ vm: Object, cancellables: inout [AnyCancellable]) {
        cancellables.append(
            vm.objectWillChange.sink { [weak self] _ in
                self?.objectWillChange.send()
            }
        )
    }
    func registerNestedObservableObject<Object: ObservableObject>(_ vm: Object, cancellable: inout AnyCancellable?) {
        cancellable = vm.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
}
