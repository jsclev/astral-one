import Foundation
import SwiftUI

public class TiledMapParser: NSObject, XMLParserDelegate {
    var filename: String
    var currentEl = ""
    var tiledTileset: TiledTileset
    private var map: Map
    var mapInitialized = false
    var mapWidth: Int32
    var mapHeight: Int32
    var firstGId: Int
    var layerOrdinal: Int
    
    public init(tiledTileset: TiledTileset, filename: String) {
        self.filename = filename
        self.tiledTileset = tiledTileset
        self.mapWidth = 60
        self.mapHeight = 60
        self.firstGId = 1
        self.layerOrdinal = 0
        self.map = Map(width: self.mapWidth, height: self.mapHeight)
    }
    
    public func parse() -> Map {
        mapInitialized = false
        currentEl = ""
        
        if let path = Bundle.main.url(forResource: filename, withExtension: ".tmx") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        
        return map
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "layer" {
            
        }
        else if elementName == "tileset" {
            if let firstGIdAttr = attributeDict["firstgid"] {
                firstGId = Int(firstGIdAttr) ?? 1
            }
        }
        else if elementName == "map" {
            if let widthAttr = attributeDict["width"] {
                // FIXME: Need to add error condition here
                mapWidth = Int32(widthAttr) ?? 0
            }
            
            if let heightAttr = attributeDict["height"] {
                mapHeight = Int32(heightAttr) ?? 0
            }
        }
        
        self.currentEl = elementName
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "layer" {
            layerOrdinal += 1
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentEl == "data" {
            if !mapInitialized {
                map = Map(width: mapWidth, height: mapHeight)
                mapInitialized = true
            }
            
            let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Make sure we are parsing the actual data CSV section, and not
            // the section that is just whitespace.  There is one part of the
            // SAX stream inside the data element that is just whitespace, it
            // is not the actual tile id matrix.
            if trimmedString.count > 0 {
                var mapRowIndex = 0
                let tileIdTable = string.components(separatedBy: "\n")
                
                for rowData in tileIdTable {
                    // Make sure we trim off any extraneous whitespace characters
                    // or punctuation characters from the row of data.  There have been
                    // Tiled files that contain a trailing comma, or a trailing tab
                    // character for some reason, so we want to make sure we get rid
                    // of all that junk.
                    let trimmedRowData = rowData
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                        .trimmingCharacters(in: .punctuationCharacters)
                    
                    if trimmedRowData.count > 0 {
                        let tileIds = trimmedRowData.components(separatedBy: ",")
                        
                        for (col, strGlobalTileId) in tileIds.enumerated() {
                            if var intGlobalTileId = Int(strGlobalTileId) {
                                // Tiled uses Global Tile IDs with a value of 0 (zero)
                                // to specify that there is no tile at this position,
                                // so we don't want to import those. See the Tiled online
                                // documentation for more information.
                                if intGlobalTileId > 0 {
                                    // Convert the Tiled global tile id to the local tileset id
                                    let intLocalTileId = intGlobalTileId - 1
                                    let strLocalTileId = String(intLocalTileId)
                                    
                                    if let tile = tiledTileset.getTile(id: strLocalTileId) {
//                                        print("Adding tile [\(tile.id),\(tile.terrainType)] at position [\(mapRowIndex),\(col),\(layerOrdinal)]")
                                        map.setTile(row: mapRowIndex,
                                                    col: col,
                                                    layer: layerOrdinal,
                                                    tile: tile)
                                    
                                    }
                                    else {
                                        fatalError("Unable to find tile id \(strLocalTileId).")
                                    }
                                }
                            }
                            else {
                                fatalError("Unable to convert the Global Tile ID \"\(strGlobalTileId)\" to an Int.")
                            }
                        }
                        
                        mapRowIndex += 1
                    }
                }
            }
        }
    }
}
