//    Copyright 2020 Swift Studies
//
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

import Foundation

enum TileDataEncoding : String, Codable {
    case csv,base64
}

enum TileDataCompression : String, Codable {
    case gzip, zlib, zstd, none
}


struct TMXTileData : Codable {
    let encoding : TileDataEncoding
    let compression : TileDataCompression?
    let data : String
    
    enum CodingKeys : String, CodingKey {
        case encoding, compression, data = ""
    }
}

public struct TMXTileLayer : XMLLayer {
    public var id: Int
    public var name: String
    public var x: Double
    public var y: Double
    public var visible: Bool
    public var opacity : Double
    public var locked : Bool
    public var tintColor : String?
    public var properties: XMLProperties

    public var data : [UInt32]

    public init(from decoder: Decoder) throws {
        let commonAttributes = try XMLLayerCommon(from: decoder)
        
        id = commonAttributes.id
        name = commonAttributes.name
        x = commonAttributes.offsetx ?? 0
        y = commonAttributes.offsety ?? 0
        visible = commonAttributes.visible ?? true
        opacity = commonAttributes.opacity ?? 1
        locked = commonAttributes.locked ?? false
        tintColor = commonAttributes.tintColor
        
        properties = try XMLProperties.decode(from: decoder)

        let rawData = try decoder.container(keyedBy: CodingKeys.self).decode(TMXTileData.self, forKey: .data)
        
        if rawData.encoding == .csv && rawData.compression == nil {
            data = rawData.data.replacingOccurrences(of: "\n", with: "").split(separator: ",").map({(UInt32($0) ?? 0)})
        } else {
            throw XMLDecodingError.unsupportedTileDataFormat(encoding: rawData.encoding, compression: rawData.compression ?? .none)
        }
    }

    
}
