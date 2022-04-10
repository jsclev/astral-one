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

public class GridGraph {
    var nodes: Dictionary<Node, Set<Node>> = [:]
    public let gridWidth: Int
    public let gridHeight: Int
    
    public init(size: Int) {
        gridWidth = size
        gridHeight = size
    }
    
    @discardableResult
    public func add(node: Node) -> Dictionary<Node, Set<Node>> {
        if nodes[node] == nil {
            nodes[node] = Set<Node>()
            
//            if node.row > gridHeight {
//                gridHeight = node.row
//            }
//
//            if node.col > gridWidth {
//                gridWidth = node.col
//            }
        }
        
        return nodes
    }
    
    @discardableResult
    public func addConnection(from: Node, to: Node) -> Dictionary<Node, Set<Node>> {
        add(node: from)
        add(node: to)
        
        // FIXME Need to rewrite the implementation below in a more robust way
        nodes[from]?.insert(to)
        
        return nodes
    }
    
    @discardableResult
    public func removeConnection(origin: Node, destination: Node) -> Dictionary<Node, Set<Node>>{
        nodes[origin]?.remove(destination)
        
        return nodes
    }
    
    @discardableResult
    public func removeNode(nodeToDelete: Node) -> Dictionary<Node, Set<Node>> {
        nodes[nodeToDelete] = nil
        
        for node in nodes.keys {
            removeConnection(origin: node, destination: nodeToDelete)
        }
        
        return nodes
    }
    
    public func node(row: Int, col: Int) -> Node? {
        for node in nodes.keys {
            if node.row == row && node.col == col {
                return node
            }
        }
        
        return nil
    }
}

public class Node: Hashable {
    public let row: Int
    public let col: Int
    
    private var tiles: [Tile] = []
    private var enemyHP: Float = 0.0
    private var enemyLandAttack: Float = 0.0
    private var enemyLandDefense: Float = 0.0
    private var avgEnemyMovement: Float = 0.0
    
    public init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    public func getTiles() -> [Tile] {
        return tiles
    }
    
    public func addTile(tile: Tile) {
        if tile.id == "" {
            fatalError("Cannot add tile with empty id.")
        }
        
        let spec = tile.spec
        if spec.tileType == TileType.Unit {
            if tile.spec.terrainType == TerrainType.Tank {
                enemyHP += 3.0
                enemyLandAttack += 10.0
                enemyLandDefense += 5.0
            }
        }
        
        tiles.append(tile)
    }
    
    public func getEnemyLandAttack() -> Float {
        return enemyLandAttack
    }
    
    public func getEnemyLandDefense() -> Float {
        return enemyLandDefense
    }
    
    public func getScore(accordingTo: Unit) -> Float {
        var score: Float = 0.0
        var help: Float = 100.0
        var threat: Float = 0.0
        var movementCost: Float = 0.0
        
        for tile in tiles {
            if tile.spec.tileType == TileType.Terrain {
                if tile.spec.terrainType == TerrainType.Forest {
                    movementCost += 1.0
                }
                else {
                    movementCost += 1.0
                }
            }
        }
        
        return help - 5.0 * movementCost - threat
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
    }
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
}
