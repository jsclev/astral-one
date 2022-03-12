import Foundation

class TiledMapParser: NSObject, XMLParserDelegate {
    var currentEl = ""
    var tileset: Tileset
    var map: Map
    var mapWidth: Int
    var mapHeight: Int
    
    init(tileset: Tileset) {
        self.tileset = tileset
        self.mapWidth = 0
        self.mapHeight = 0
        self.map = Map(width: self.mapWidth, height: self.mapHeight)
    }
    
    func parse() -> Map {
        currentEl = ""
        
        if let path = Bundle.main.url(forResource: "map", withExtension: ".tmx") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        
        return map
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "map" {
            if let widthAttr = attributeDict["width"] {
                mapWidth = Int(widthAttr) ?? 0
            }
            
            if let heightAttr = attributeDict["height"] {
                mapHeight = Int(heightAttr) ?? 0
            }
        }
        
        self.currentEl = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentEl == "data" {
            let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
            //            print(string)
            
            if trimmedString.count > 0 {
                self.map = Map(width: mapWidth, height: mapHeight)
                var mapRowIndex = 0
                let tileIdTable = string.components(separatedBy: "\n")
                
                for rowData in tileIdTable {
                    let trimmedRowData = rowData.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if trimmedRowData.count > 0 {
                        //                    print("Row index: \(rowIndex), data: \(rowData)")
                        let tileIds = trimmedRowData.components(separatedBy: ",")
                        
                        for (colIndex, tileId) in tileIds.enumerated() {
                            if let tile = tileset.getTile(id: tileId) {
                                map.tiles[mapRowIndex][colIndex] = tile
                                
                                if tileId != "0" {
                                    print(map.tiles[mapRowIndex][colIndex].id)
                                }
                            }
                        }
                        
                        mapRowIndex += 1
                    }
                }
            }
        }
    }
}
