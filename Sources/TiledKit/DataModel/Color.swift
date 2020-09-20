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

public struct Color : Decodable, Equatable{
    public let red:Byte, green:Byte, blue:Byte, alpha:Byte
    
    //Tiled represents colors in the form of a string #AARRGGBB
    public init(from string:String){
        if string.hasPrefix("#") {
            if string.count == 7 {
                alpha = 255
                red   = Byte(string[1..<3], radix: 16) ?? 255
                green = Byte(string[3..<5], radix: 16) ?? 0
                blue  = Byte(string[5..<7], radix: 16) ?? 255

            } else {
                alpha = Byte(string[1..<3], radix: 16) ?? 255
                red   = Byte(string[3..<5], radix: 16) ?? 255
                green = Byte(string[5..<7], radix: 16) ?? 0
                blue  = Byte(string[7..<9], radix: 16) ?? 255
            }
        } else {
            if string.count == 6 {
                alpha = 255
                red   = Byte(string[0..<2], radix: 16) ?? 255
                green = Byte(string[2..<4], radix: 16) ?? 0
                blue  = Byte(string[4..<6], radix: 16) ?? 255

            } else {
                alpha = Byte(string[0..<2], radix: 16) ?? 255
                red   = Byte(string[2..<4], radix: 16) ?? 255
                green = Byte(string[4..<6], radix: 16) ?? 0
                blue  = Byte(string[6..<8], radix: 16) ?? 255
            }
        }
    }
    
    public init(r:Byte, g:Byte, b:Byte, a:Byte = 255){
        red = r
        green = g
        blue = b
        alpha = a
    }
    
    public init(from decoder:Decoder) throws {
        let stringValue = try decoder.singleValueContainer().decode(String.self)
        let colorObject = Color(from: stringValue)
        red = colorObject.red
        green = colorObject.green
        blue = colorObject.blue
        alpha = colorObject.alpha
    }
}


