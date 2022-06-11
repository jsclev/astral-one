import Foundation

public class TiledTilesetParser: NSObject, XMLParserDelegate {
    var terrains: [TiledTerrain] = []
    var specialResources: [TiledSpecialResource] = []
    var elementName = ""
    var tileId = ""
    
    public func parse() -> TiledTileset {
        terrains = []
        specialResources = []
        elementName = ""
        tileId = ""
        
        if let path = Bundle.main.url(forResource: Constants.tilesetName, withExtension: ".tsx") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        else {
            fatalError("Unable to find Tiled tileset \"\(Constants.tilesetName).tsx\" in app bundle.")
        }
        
        return TiledTileset(name: "Game Tile Set",
                            terrains: terrains,
                            specialResources: specialResources)
    }
    
    public func parser(_ parser: XMLParser,
                       didStartElement elementName: String,
                       namespaceURI: String?,
                       qualifiedName qName: String?,
                       attributes attributeDict: [String : String] = [:]) {
        if elementName == "tile" {
            if let idAttribute = attributeDict["id"] {
                tileId = idAttribute
            }
        }
        
        self.elementName = elementName
    }
    
    public func parser(_ parser: XMLParser,
                       didEndElement elementName: String,
                       namespaceURI: String?,
                       qualifiedName qName: String?) {
        if elementName == "tile" {
            if let terrainType = Constants.terrainTypes[tileId] {
                terrains.append(TiledTerrain(id: tileId,
                                             terrainType: terrainType))
            }
            else if let specialResource = Constants.specialResources[tileId] {
                specialResources.append(TiledSpecialResource(id: tileId,
                                                             specialResource: specialResource))
            }
            else {
                fatalError("Unable to parse Tiled Id \(tileId).")
            }
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {

    }
}
