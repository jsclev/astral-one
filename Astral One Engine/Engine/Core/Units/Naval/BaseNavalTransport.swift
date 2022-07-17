import Foundation
import Combine

public class BaseNavalTransport: Unit {
    public let maxCapacity: Int
    @Published var units: [Unit] = []
    
    public init(id: Int,
                player: Player,
                theme: Theme,
                tiledId: Int,
                name: String,
                assetName: String,
                cost: Double,
                maxHp: Double,
                attack: Double,
                defense: Double,
                fp: Double,
                maxMovementPoints: Double,
                position: Position,
                maxCapacity: Int) {
        self.maxCapacity = maxCapacity
        
        super.init(id: id,
                   player: player,
                   theme: theme,
                   tiledId: tiledId,
                   name: name,
                   assetName: assetName,
                   cost: cost,
                   maxHp: maxHp,
                   attack: attack,
                   defense: defense,
                   fp: fp,
                   maxMovementPoints: maxMovementPoints,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func clone() -> Unit {
        fatalError("clone() must be implemented in subclasses.")
    }
    
    public func addUnit(unit: Unit) {
        if units.count < maxCapacity {
            units.append(unit)
        }
    }
}
