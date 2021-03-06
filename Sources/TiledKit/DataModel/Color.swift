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


/// Captures colors in a platform independent way for subsequent specialization.
public struct Color : Equatable{
    /// The amount of red in the color from 0 to 255
    public let red:Byte

    /// The amount of green in the color from 0 to 255
    public let green:Byte

    /// The amount of blue in the color from 0 to 255
    public let blue:Byte

    /// The opacity of color from 0 to 255
    public let alpha:Byte
    
    /// Construct a color from any of the different string forms they appear in in Tiled
    init(from string:String){
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
    
    /// Construct a color from any of the different string forms they appear in in Tiled
    init?(from string:String?){
        if let string = string {
            self.init(from: string)
        } else {
            return nil
        }
    }
    
    
    /// Constructs a new `Color` instance with the specified RGBA (alpha is optional)
    ///
    /// - Parameters:
    ///   - r: The amount of red in the color from 0 to 255
    ///   - g: The amount of green in the color from 0 to 255
    ///   - b: The amount of blue in the color from 0 to 255
    ///   - a: The opacity of the color from 0 to 255 (0 fully transparent, 255 fully opaque)
    public init(r:Byte, g:Byte, b:Byte, a:Byte = 255){
        red = r
        green = g
        blue = b
        alpha = a
    }
    
    internal var tiledFormatDescription : String {
        let format = "%02hhx"
        return "#\(String(format: format , red))\(String(format: format , green))\(String(format: format , blue))"
    }
    
    /// Predefined white color
    public static let white = Color(r: 255, g: 255, b: 255)
    
    /// Predefined black color
    public static let black = Color(r: 0, g: 0, b: 0)

    /// Predefined red color
    public static let red = Color(r: 255, g: 0, b: 0)

    /// Predefined green color
    public static let green = Color(r: 0, g: 255, b: 0)

    /// Predefined blue color
    public static let blue = Color(r: 0, g: 0, b: 255)
    
    /// Predefined magenta color
    public static let magenta = Color(r: 255, g: 0, b: 255)

    /// Predefined cyan color
    public static let cyan = Color(r: 0, g: 255, b: 255)

    /// Predefined yellow color
    public static let yellow = Color(r: 255, g: 255, b: 0)

    /// Predefined grey color
    public static let grey = Color(r: 128, g: 128, b: 128)

    /// Predefined light grey color
    public static let lightGrey = Color(r: 191, g: 191, b: 191)

    /// Predefined dark grey color
    public static let darkGrey = Color(r: 98, g: 98, b: 98)

    /// Predefined brown color
    public static let brown = Color(r: 155, g: 99, b: 0)

    /// Predefined orange color
    public static let orange = Color(r: 255, g: 155, b: 0)

    /// Predefined pink color
    public static let pink = Color(r: 255, g: 155, b: 255)

    /// Predefined clear color (transparent black)
    public static let clear = Color(r: 0, g: 0, b: 0, a: 0)
}

/// Convenience extension for parsing the color string
fileprivate extension String {
    subscript(_ range:Range<Int>)->String{
        let lower = index(startIndex, offsetBy: range.lowerBound)
        let upper = index(startIndex, offsetBy: range.upperBound)
        return String(self[lower..<upper])
    }
}
