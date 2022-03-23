import Foundation

public class TiledTilesetParser: NSObject, XMLParserDelegate {
    let filename: String
    var tiles: [Tile] = []
    var elementName = ""
    var tileId = ""
    var walkable: Bool = true
    
    public init(_ filename: String) {
        self.filename = filename
    }
    
    public func parse() -> Tileset {
        tiles = []
        elementName = ""
        tileId = ""
        walkable = true
        
        if let path = Bundle.main.url(forResource: filename, withExtension: ".tsx") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        else {
            fatalError("Unable to find Tiled tileset file \"\(filename).tsx\" in app bundle.")
        }
        
        return Tileset(name: "Game Tile Set", tiles: tiles)
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "tile" {
            if let idAttribute = attributeDict["id"] {
                tileId = idAttribute
            }
        }
        else if elementName == "property" {
            if let nameAttr = attributeDict["name"], let valueAttr = attributeDict["value"] {
                if nameAttr == "Walkable" {
                    if valueAttr == "false" {
                        walkable = false
                    }
                }
            }
        }
        
        self.elementName = elementName
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "tile" {
            if let terrainType = Constants.terrainTypes[tileId] {
                tiles.append(Tile(id: tileId,
                                  walkable: walkable,
                                  terrainType: terrainType))
                walkable = true
            }
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {

    }
}
