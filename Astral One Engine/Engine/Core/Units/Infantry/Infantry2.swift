import Foundation

public class Infantry2: Unit {
    /*
     In Civilization II this is equivalent to a Phalanx unit.
     */
    public convenience init(player: Player,
                            theme: Theme,
                            skin: Skin,
                            name: String,
                            position: Position) {
        self.init(id: Constants.noId,
                  player: player,
                  theme: theme,
                  skin: skin,
                  name: name,
                  position: position)
    }
    
    public init(id: Int,
                player: Player,
                theme: Theme,
                skin: Skin,
                name: String,
                position: Position) {
        super.init(id: id,
                   player: player,
                   theme: theme,
                   skin: skin,
                   tiledId: 100,
                   name: name,
                   assetName: "Units/Infantry/infantry-2",
                   cost: 20,
                   maxHp: 1,
                   attack: 1,
                   defense: 2,
                   fp: 1,
                   maxMovementPoints: 1.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func clone() -> Unit {
        return Infantry2(player: player,
                         theme: theme,
                         name: name,
                         position: position)
    }
}
