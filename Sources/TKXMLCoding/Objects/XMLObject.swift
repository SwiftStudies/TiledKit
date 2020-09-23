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


public struct XMLObject : Codable{
    public let id : Int
    public let name : String
    public let x : Double
    public let y : Double
    public let visible : Bool
    
    public let properties : XMLProperties
    public let type : ObjectType

    enum CodingKeys : String, CodingKey {
        case id, name, x, y, visible, width, height, point, elipse, polygon, polyline, text, tile = "gid", properties
    }
    
    public enum ObjectType {
        case point, tile(UInt32, size: XMLDimension), rectangle(XMLDimension), elipse(XMLDimension), polyline(XMLPologonal), polygon(XMLPologonal), text(XMLText, size: XMLDimension)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        x = try container.decode(Double.self, forKey: .x)
        y = try container.decode(Double.self, forKey: .y)
        visible = try container.decodeIfPresent(Bool.self, forKey: .visible) ?? true
        properties = try XMLProperties.decode(from: decoder)
        
        if container.contains(.point){
            type = .point
        } else if container.contains(.elipse){
            type = .elipse(try XMLDimension.decode(from: decoder))
        } else if container.contains(.polygon) {
            type = .polygon(try container.decode(XMLPologonal.self, forKey: .polygon))
        } else if container.contains(.polyline){
            type = .polyline(try container.decode(XMLPologonal.self, forKey: .polyline))
        } else if container.contains(.tile){
            type = .tile(
                try container.decode(UInt32.self, forKey: .tile),
                size:try XMLDimension.decode(from: decoder))

        } else if container.contains(.text){
            type = .text(
                try container.decode(XMLText.self, forKey: .text),
                size: try XMLDimension.decode(from: decoder))
        } else {
            type = .rectangle(try XMLDimension.decode(from: decoder))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        fatalError("Not supported")
    }
    
}
