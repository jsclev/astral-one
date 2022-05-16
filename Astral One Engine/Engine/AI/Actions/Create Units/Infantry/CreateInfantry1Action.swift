import Foundation

public class CreateInfantry1Action: Action {
//    private let city: City
    public init() {
//        self.city = city
        super.init(id: 2, name: "Create Infantry1")
        
        preconditions = []
        effects = []
        cost = 10
    }
    
//    public override func execute(game: Game, player: Player) {
//        let unit = Infantry1(game: game,
//                             player: player,
//                             theme: game.theme,
//                             name: "Warrior",
//                             position: city.position)
//
//        if city.has(building: BuildingType.Barracks) {
//            unit.makeVeteran()
//        }
//
//        player.add(unit: unit)
//    }
    
    public override func execute(game: Game, player: Player, city: City) {
        let unit = Infantry1(game: game,
                             player: player,
                             theme: game.theme,
                             name: "Warrior",
                             position: city.position)
        
        if city.has(building: BuildingType.Barracks) {
            unit.makeVeteran()
        }
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateInfantry1Action()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
