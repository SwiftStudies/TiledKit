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

public struct TextStyle {
    public let wrap : Bool
    public let fontFamily : String?
    public let pixelSize : Int
    public let color : Color
    public let verticalAlignment : VerticalTextAlignment
    public let horizontalAlignment : HorizontalTextAlignment
    public let bold : Bool
    public let italic : Bool
    public let underline : Bool
    public let strikeout : Bool
    public let kerning : Bool
    
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
