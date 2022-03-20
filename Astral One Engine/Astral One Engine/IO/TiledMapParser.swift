import Foundation
import SwiftUI

public class TiledMapParser: NSObject, XMLParserDelegate {
    var filename: String
    var currentEl = ""
    var tileset: Tileset
    var map: Map
    var mapWidth: Int32
    var mapHeight: Int32
    var firstGId: Int
    
    public init(tileset: Tileset, filename: String) {
        self.filename = filename
        self.tileset = tileset
        self.mapWidth = 0
        self.mapHeight = 0
        self.firstGId = 1
        self.map = Map(width: self.mapWidth, height: self.mapHeight)
    }
    
    public func parse() -> Map {
        currentEl = ""
        
//        var filename = "map-"
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            filename += "phone"
//        }
//        else {
//            filename += "ipad"
//        }
        
        if let path = Bundle.main.url(forResource: filename, withExtension: ".tmx") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        
        return map
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "tileset" {
            if let firstGIdAttr = attributeDict["firstgid"] {
                firstGId = Int(firstGIdAttr) ?? 1
            }
        }
        
        if elementName == "map" {
            if let widthAttr = attributeDict["width"] {
                mapWidth = Int32(widthAttr) ?? 0
            }
            
            if let heightAttr = attributeDict["height"] {
                mapHeight = Int32(heightAttr) ?? 0
            }
        }
        
        self.currentEl = elementName
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentEl == "data" {
            let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Make sure we are parsing the actual data CSV section, and not
            // the section that is just whitespace.  There is one part of the
            // SAX stream inside the data element that is just whitespace, it
            // is not the actual tile id matrix.
            if trimmedString.count > 0 {
//                print(trimmedString)
//                print("**************************************************************************")
                self.map = Map(width: mapWidth, height: mapHeight)
                var mapRowIndex = 0
                let tileIdTable = string.components(separatedBy: "\n")
                
                for rowData in tileIdTable {
                    let trimmedRowData = rowData.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if trimmedRowData.count > 0 {
                        let tileIds = trimmedRowData.components(separatedBy: ",")
                        
                        for (colIndex, tileId) in tileIds.enumerated() {
                            var intTileId = Int(tileId) ?? 0
                            intTileId -= firstGId
                            
                            if let tile = tileset.getTile(id: String(intTileId)) {
                                map.tiles[mapRowIndex][colIndex] = tile
                                
//                                if tileId != "0" && tile.walkable {
//                                    print("Non walkable: " + map.tiles[mapRowIndex][colIndex].id)
//                                }
                            }
                        }
                        
                        mapRowIndex += 1
                    }
                }
            }
        }
    }
}
