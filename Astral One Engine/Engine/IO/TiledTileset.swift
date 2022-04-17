import Foundation

public struct TiledTileset {
    var name: String
    var tiles: [Tile2] = []
    
    func getTile(id: String) -> Tile2? {
        for tile in tiles {
            if tile.id == id {
                return tile
            }
        }
        
        return nil
    }
}
