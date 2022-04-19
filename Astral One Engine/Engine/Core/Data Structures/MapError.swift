public enum MapError: Error, Equatable {
    case invalidRow(message: String, row: Int)
    case invalidCol(message: String, col: Int)
}
