import Foundation

public struct TiledTileset {
    var name: String
    var tiles: [Tile] = []
    
    func getTile(id: String) -> Tile? {
        for tile in tiles {
            if tile.id == id {
                return tile
            }
        }
        
        return nil
    }
}
