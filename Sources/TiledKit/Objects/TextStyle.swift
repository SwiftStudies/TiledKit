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

/// The desired horizontal position of the text inside the bounds specified
public enum HorizontalTextAlignment : String, Codable {
    /// Align the text against the left side of the bounding rectangle
    case left
    
    /// Align the text in the center of the bounding rectangle
    case center
    
    /// Align the text against the right hand side of the bounding rectangle
    case right
    
    /// Align the text against the left side of the bounding rectangle keeping the right hand side aligned against the same vertical line
    case justified
}

/// The desired vertical position of the text inside the bounds specified
public enum VerticalTextAlignment : String, Codable {
    /// Text should be aligned against the top of the bounding rectangle
    case top
    
    /// Text should be in the middle of the bounding rectangle
    case middle = "center"
    
    /// Text should be at aligned with the bottom of the bounding rectangle
    case bottom
}

/// Represents the formating and style of text `Object`s.
public struct TextStyle : Equatable {
    /// Text should be wrapped inside the bounding rectangle
    public let wrap : Bool
    /// The desired font (if any) of the text
    public let fontFamily : String?
    
    /// The size in pixels the text should be rendered at
    public let pixelSize : Int
    
    /// The color the text should be rendered in
    public let color : Color
    
    /// The vertical alignment of the text within the bounding rectangle
    public let verticalAlignment : VerticalTextAlignment
    
    /// The horizontal alignement of the text within the bounding rectangle
    public let horizontalAlignment : HorizontalTextAlignment
    
    /// Specifies if the text should be rendered in bold
    public let bold : Bool
    
    /// Specifies if the text should be rendered with italics
    public let italic : Bool
    
    /// Specifies if the text should be underlined when rendered
    public let underline : Bool
    
    /// Specifies if the text should be struck out when rendered
    public let strikeout : Bool
    
    /// Specifies if kerning should be applied to the rendered text
    public let kerning : Bool
    
    /// Creates a new instance of a `TextStyle` object
    /// - Parameters:
    ///   - fontFamily: The desired font family (can be and defaults to `nil`
    ///   - size: The desired size of the text
    ///   - color: The desired color of the text
    ///   - verticalAlignment: The desired horizontal alignment of the text inside the text `Object`s bounding rectangle
    ///   - horizontalAlignment: The desired vertical alignment of the text inside the text `Object`s bounding rectangle
    ///   - bold: `true` if the text should be rendered in bold
    ///   - italic: `true` if the text should be rendered in italics
    ///   - underline: `true` if the text should be underlined
    ///   - strikeout: `true` if the text should be struck out
    ///   - kerning: `true` if the kerning should be applied during text rendering
    ///   - wrap: `true` if the text should be wrapped within the text `Object`s bounding rectangle
    public init(fontFamily:String? = nil, size:Int = 16, color:Color = Color(r: 255, g: 255, b: 255), verticalAlignment: VerticalTextAlignment = .top, horizontalAlignment:HorizontalTextAlignment = .left, bold: Bool = false, italic: Bool = false, underline:Bool = false, strikeout:Bool = false, kerning:Bool = true,  wrap:Bool = true){
        self.wrap = wrap
        self.fontFamily = fontFamily
        self.pixelSize = size
        self.color = color
        self.verticalAlignment = verticalAlignment
        self.horizontalAlignment = horizontalAlignment
        self.bold = bold
        self.italic = italic
        self.underline = underline
        self.strikeout = strikeout
        self.kerning = kerning

    }
}
