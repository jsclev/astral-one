import Foundation

struct Tileset {
    var name: String
    var tiles: [Tile] = []
    
    func isWalkable(tileId: String) -> Bool {
        for tile in tiles {
            if tile.id == tileId {
                return tile.walkable
            }
        }
        
        return true
    }
    
    func getTile(id: String) -> Tile? {
        for tile in tiles {
            if tile.id == id {
                return tile
            }
        }
        
        return nil
    }
}
