import Foundation

public class TiledTilesetParser: NSObject, XMLParserDelegate {
    let filename: String
    var tiles: [Tile2] = []
    var elementName = ""
    var tileId = ""
    
    public init(_ filename: String) {
        self.filename = filename
    }
    
    public func parse() -> TiledTileset {
        tiles = []
        elementName = ""
        tileId = ""
        
        if let path = Bundle.main.url(forResource: filename, withExtension: ".tsx") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        else {
            fatalError("Unable to find Tiled tileset file \"\(filename).tsx\" in app bundle.")
        }
        
        return TiledTileset(name: "Game Tile Set", tiles: tiles)
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "tile" {
            if let idAttribute = attributeDict["id"] {
                tileId = idAttribute
            }
        }
        
        self.elementName = elementName
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "tile" {
            if let tileSpec = Constants.terrainTypes[tileId] {
                tiles.append(Tile2(id: tileId, spec: tileSpec, ordinal: 0))
            }
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {

    }
}
