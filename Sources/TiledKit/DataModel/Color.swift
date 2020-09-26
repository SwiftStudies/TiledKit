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

/// Explicit type for bytes
public typealias Byte = UInt8

fileprivate extension String {
    subscript(_ range:Range<Int>)->String{
        let lower = index(startIndex, offsetBy: range.lowerBound)
        let upper = index(startIndex, offsetBy: range.upperBound)
        return String(self[lower..<upper])
    }
}

public struct Color : Equatable{
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
    
    public static let white = Color(r: 255, g: 255, b: 255)
    public static let black = Color(r: 0, g: 0, b: 0)
    public static let clear = Color(r: 0, g: 0, b: 0, a: 0)
}


