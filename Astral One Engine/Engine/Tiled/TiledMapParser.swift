import Foundation
import SwiftUI

public class TiledMapParser: NSObject, XMLParserDelegate {
    var filename: String
    var currentEl = ""
    var tiledTileset: TiledTileset
    private var map: Map
    var mapInitialized = false
    var mapWidth: Int = 0
    var mapHeight: Int = 0
    var firstGId: Int = 1
    var layerOrdinal: Int = 0
    var terrains: [Terrain] = []
    var hasRivers: [Position: Bool]
    
    public init(tiledTileset: TiledTileset, filename: String) {
        self.filename = filename
        self.tiledTileset = tiledTileset
        self.map = Map(mapId: 1, width: mapWidth, height: mapHeight)
        self.hasRivers = [Position: Bool]()
    }
    
    public func parse() throws -> Map {
        layerOrdinal = 0
        mapInitialized = false
        currentEl = ""
        hasRivers = [Position: Bool]()
        try terrains = Constants.db.terrainDao.getTerrains()
        
        if terrains.count == 0 {
            fatalError("Unable to get terrains from database.")
        }
        
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
                mapWidth = Int(widthAttr) ?? 0
            }
            
            if let heightAttr = attributeDict["height"] {
                mapHeight = Int(heightAttr) ?? 0
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
                map = Map(mapId: 1, width: mapWidth, height: mapHeight)
                mapInitialized = true
            }
            
            if mapWidth == 0 || mapHeight == 0 {
                fatalError("Map width and height must be greater than 0.")
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
                        let tiledIds = trimmedRowData.components(separatedBy: ",")

                        for (col, strGlobalTiledId) in tiledIds.enumerated() {
                            if let intGlobalTiledId = Int(strGlobalTiledId) {
                                // Tiled uses Global Tile IDs with a value of 0 (zero)
                                // to specify that there is no tile at this position,
                                // so we don't want to import those. See the Tiled online
                                // documentation for more information.
                                if intGlobalTiledId > 0 {
                                    // Convert the Tiled global tile id to the local tileset id
                                    let intLocalTiledId = intGlobalTiledId - 1
                                    let strLocalTiledId = String(intLocalTiledId)
                                    let row = mapHeight - 1 - mapRowIndex
                                    let position = Position(row: row, col: col)

                                    if let tiledId = Int(strLocalTiledId) {
                                        if let terrain = getTerrain(tiledId: tiledId) {
                                            map.add(tile: Tile(position: position,
                                                               terrain: terrain,
                                                               hasRiver: false))
                                        }
                                        else if tiledId == Constants.riverTiledId {
                                            let tile = map.tile(at: position)
                                            map.add(tile: Tile(position: position,
                                                               terrain: tile.terrain,
                                                               hasRiver: true))
                                        }
                                        else if let specialResource = Constants.specialResources[strLocalTiledId] {
                                            let tile = map.tile(at: position)
                                            map.add(tile: Tile(id: Constants.noId,
                                                               position: position,
                                                               terrain: tile.terrain,
                                                               specialResource: specialResource,
                                                               hasRiver: tile.hasRiver))
                                        }
                                        else {
                                            var msg = "Unable to find tile with Tiled ID \(strLocalTiledId).  "
                                            msg += "Check the Tiled tileset file (.tsx) to make sure there is "
                                            msg += "a tile with an id of \(strLocalTiledId) in it."
                                            fatalError(msg)
                                        }
                                    }
                                }
                            }
                            else {
                                fatalError("Unable to convert the Global Tile ID \"\(strGlobalTiledId)\" to an Int.")
                            }
                        }

                        mapRowIndex += 1
                    }
                }
            }
        }
    }
    
    private func getTerrain(tiledId: Int) -> Terrain? {
        for terrain in terrains {
            if terrain.tiledId == tiledId {
                return terrain
            }
        }
        
        return nil
    }
}
