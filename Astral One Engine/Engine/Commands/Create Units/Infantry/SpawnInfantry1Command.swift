import Foundation

public class SpawnInfantry1Action: Action {
    private let goodieHut: GoodieHut
    
    public init(game: Game, player: Player, goodieHut: GoodieHut) {
        self.goodieHut = goodieHut
        super.init(id: 2, name: "Spawn Infantry1", game: game, player: player)
        
        preconditions = []
        effects = []
    }
    
    public override func execute() {
        player.add(unit: Infantry1(player: player,
                                   theme: game.theme,
                                   name: "Warrior",
                                   position: goodieHut.position))
    }
    
    public override func clone() -> Action {
        let copy = SpawnInfantry1Action(game: game, player: player, goodieHut: goodieHut)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
