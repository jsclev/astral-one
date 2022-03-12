import Foundation

struct Map {
    var tiles: [[Tile]] = [[]]
    var width = 0
    var height = 0
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        
        tiles = Array(repeating: Array(repeating: Tile(), count: width), count: height)
    }
}
