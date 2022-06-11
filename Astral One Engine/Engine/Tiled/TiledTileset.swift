import Foundation

public struct TiledTileset {
    var name: String
    var terrains: [TiledTerrain] = []
    var specialResources: [TiledSpecialResource] = []
    
    func getTerrain(id: String) -> TiledTerrain? {
        for terrain in terrains {
            if terrain.id == id {
                return terrain
            }
        }
        
        return nil
    }
    
    func getSpecialResource(id: String) -> TiledSpecialResource? {
        for specialResource in specialResources {
            if specialResource.id == id {
                return specialResource
            }
        }
        
        return nil
    }
}
