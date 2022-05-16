import Foundation

public class SpawnInfantry1Action: Action {
    private let goodieHut: GoodieHut
    
    public init(goodieHut: GoodieHut) {
        self.goodieHut = goodieHut
        super.init(id: 2, name: "Spawn Infantry1")
        
        preconditions = []
        effects = []
    }
    
    public override func execute(game: Game, player: Player) {
        player.add(unit: Infantry1(game: game,
                                   player: player,
                                   theme: game.theme,
                                   name: "Warrior",
                                   position: goodieHut.position))
    }
    
    public override func clone() -> Action {
        let copy = SpawnInfantry1Action(goodieHut: goodieHut)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
