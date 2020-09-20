//
//  File.swift
//  
//
//  Created by Hughes, Nigel on 9/20/20.
//

import Foundation

public enum HorizontalTextAlignment : String, Codable {
    case left, center, right, justified
}

public enum VerticalTextAlignment : String, Codable {
    case top, middle = "center", bottom
}

struct TextDefinition : Decodable {
    var string : String
    var wrap : Bool
    var fontFamily : String?
    var pixelSize : Int
    var color : Color
    var verticalAlignment = VerticalTextAlignment.middle
    var horizontalAlignment = HorizontalTextAlignment.center
    var bold : Bool
    var italic : Bool
    var underline : Bool
    var strikeout : Bool
    var kerning : Bool
    
    enum CodingKeys : String, CodingKey {
        case wrap, fontFamily = "fontfamily", color, verticalAlignment = "valign", horizontalAlignment = "halign"
        case bold, italic, underline, strikeout, kerning, pixelSize = "pixelsize"
        case string = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        string = try container.decode(String.self, forKey: .string)
        wrap = try container.decodeIfPresent(Int.self, forKey: .wrap) ?? 1 == 1
        fontFamily = try container.decodeIfPresent(String.self, forKey: .fontFamily)
        pixelSize = try container.decodeIfPresent(Int.self, forKey: .pixelSize) ?? 16
        color = try container.decodeIfPresent(Color.self, forKey: .color) ?? Color(r: 255, g: 255, b: 255)
        verticalAlignment = try container.decodeIfPresent(VerticalTextAlignment.self, forKey: .verticalAlignment) ?? .middle
        horizontalAlignment = try container.decodeIfPresent(HorizontalTextAlignment.self, forKey: .horizontalAlignment) ?? .center
        bold = try container.decodeIfPresent(Int.self, forKey: .bold) ?? 0 == 1
        italic = try container.decodeIfPresent(Int.self, forKey: .italic) ?? 0 == 1
        underline = try container.decodeIfPresent(Int.self, forKey: .underline) ?? 0 == 1
        strikeout = try container.decodeIfPresent(Int.self, forKey: .strikeout) ?? 0 == 1
        kerning =  try container.decodeIfPresent(Int.self, forKey: .kerning) ?? 1 == 1
    }
    
}
