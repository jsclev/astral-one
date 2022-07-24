import Foundation

public class Infantry8: Unit {
    /*
     In Civilization II this is equivalent to a Mechanized Infantry unit.
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
                   assetName: "Units/Infantry/infantry-8",
                   cost: 50,
                   maxHp: 30,
                   attack: 6,
                   defense: 6,
                   fp: 1,
                   maxMovementPoints: 3.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
