import Foundation
import GameplayKit

public class FogOfWarGenerator {
    public let player: Player
    
    public init(player: Player) {
        self.player = player
    }
    
    public func generate() {
        let size = vector2(Double(8 * player.map.width), Double(8 * player.map.height))
        let noise = GKNoise(GKPerlinNoiseSource())
        let noiseMap = GKNoiseMap.init(noise,
                                       size: size,
                                       origin: vector2(0, 0),
                                       sampleCount: vector2(100, 100), seamless: true)
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let position = Position(row: row, col: col)
                
                if noiseMap.value(at: vector_int2(Int32(row), Int32(col))) > 0.20 {
                    player.map.tile(at: position).set(visibility: Visibility.FogOfWar)
                }
                else {
                    player.map.tile(at: position).set(visibility: Visibility.FullyRevealed)
                }
            }
        }
    }
}
