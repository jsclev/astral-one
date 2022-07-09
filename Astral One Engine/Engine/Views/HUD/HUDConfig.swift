import Foundation

public enum HUDPosition {
    case Northwest
    case West
    case SouthWest
    case South
    case Southeast
    case East
    case Northeast
    case North
}

public enum HUDControl {
    case Minimap
    case Turn
    
}

public class HUDConfig {
    public init() {
        
    }
    
    public var nextTurnButton: HUDPosition {
        return HUDPosition.Southeast
    }
    
    public var minimap: HUDPosition {
        return HUDPosition.SouthWest
    }
    
    public var turnIndicator: HUDPosition {
        return HUDPosition.Northeast
    }
    
    public var researchButton: HUDPosition {
        return HUDPosition.Northwest
    }
}
