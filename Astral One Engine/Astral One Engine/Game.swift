import Foundation
import Combine

public class Game: ObservableObject {
    @Published public var showFPS = false

    private var map: Map = Map(width: 0, height: 0)
    public let db: Db

    public init(db: Db) {
        self.db = db
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
    
    public func processCommands(commands: [Command]) {
        for command in commands {
            print(command)
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

public class GameGridGraph {
    var nodes: Dictionary<GameGridGraphNode, Set<GameGridGraphNode>> = [:]
    
    public init() {
        print("initializing grid graph")
    }
    
    @discardableResult public func addNode(nodeToAdd: GameGridGraphNode) -> Dictionary<GameGridGraphNode, Set<GameGridGraphNode>> {
        if nodes[nodeToAdd] == nil {
            nodes[nodeToAdd] = Set<GameGridGraphNode>()
        }
        
        return nodes
    }
    
    @discardableResult public func addConnection(origin: GameGridGraphNode, destination: GameGridGraphNode) -> Dictionary<GameGridGraphNode, Set<GameGridGraphNode>> {
        addNode(nodeToAdd: origin)
        addNode(nodeToAdd: destination)
        
        // FIXME Need to rewrite the implementation below in a more robust way
        nodes[origin]?.insert(destination)
        
        return nodes
    }
    
    @discardableResult public func removeConnection(origin: GameGridGraphNode, destination: GameGridGraphNode) -> Dictionary<GameGridGraphNode, Set<GameGridGraphNode>>{
        nodes[origin]?.remove(destination)
        
        return nodes
    }
    
    @discardableResult public func removeNode(nodeToDelete: GameGridGraphNode) -> Dictionary<GameGridGraphNode, Set<GameGridGraphNode>> {
        nodes[nodeToDelete] = nil
        
        for node in nodes.keys {
            removeConnection(origin: node, destination: nodeToDelete)
        }
        
        return nodes
    }
}

public class GameGridGraphNode: Hashable {
    private let row: Int
    private let col: Int
    
    public init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
    }
    
    public static func == (lhs: GameGridGraphNode, rhs: GameGridGraphNode) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
}
