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


public struct XMLText : Codable {
    public let string : String
    public let wrap : Bool
    public let fontFamily : String?
    public let pixelSize : Int
    public let color : String
    public let verticalAlignment : String
    public let horizontalAlignment : String
    public let bold : Bool
    public let italic : Bool
    public let underline : Bool
    public let strikeout : Bool
    public let kerning : Bool
    
    enum CodingKeys : String, CodingKey {
        case wrap , fontFamily = "fontfamily", color , verticalAlignment = "valign", horizontalAlignment = "halign"
        case bold, italic, underline, strikeout, kerning, pixelSize = "pixelsize"
        case string = ""
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        string = try container.decode(String.self, forKey: .string)
        wrap = try container.decodeIfPresent(Bool.self, forKey: .wrap) ?? true
        fontFamily = try container.decodeIfPresent(String.self, forKey: .fontFamily)
        pixelSize = try container.decodeIfPresent(Int.self, forKey: .pixelSize) ?? 16
        color = try container.decodeIfPresent(String.self, forKey: .color) ?? "#ffffff"
        verticalAlignment = try container.decodeIfPresent(String.self, forKey: .verticalAlignment) ?? "top"
        horizontalAlignment = try container.decodeIfPresent(String.self, forKey: .horizontalAlignment) ?? "left"
        bold = try container.decodeIfPresent(Int.self, forKey: .bold) ?? 0 == 1
        italic = try container.decodeIfPresent(Int.self, forKey: .italic) ?? 0 == 1
        underline = try container.decodeIfPresent(Int.self, forKey: .underline) ?? 0 == 1
        strikeout = try container.decodeIfPresent(Int.self, forKey: .strikeout) ?? 0 == 1
        kerning =  try container.decodeIfPresent(Int.self, forKey: .kerning) ?? 1 == 1
    }
    
}
