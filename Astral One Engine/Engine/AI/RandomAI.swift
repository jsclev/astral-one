import Foundation

public class RandomAI {
    private let player: Player
    
    public init(player: Player) {
        self.player = player
    }
    
    public func nextAction() -> Action {
        return player.getRandomAvailableAction()
    }
}
