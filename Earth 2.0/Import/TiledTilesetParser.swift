import Foundation

class TiledTilesetParser: NSObject, XMLParserDelegate {
    var tiles: [Tile] = []
    var elementName = ""
    var tileId = ""
    var walkable: Bool = true
    
    func parse() -> Tileset {
        tiles = []
        elementName = ""
        tileId = ""
        walkable = true
        
        if let path = Bundle.main.url(forResource: "Astral One", withExtension: ".tsx") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        
        return Tileset(name: "Astral One Tileset", tiles: tiles)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
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
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "tile" {
            tiles.append(Tile(id: tileId, walkable: walkable))
            walkable = true
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {

    }
}
