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

/// The file types, and some basic information about them, that are supported by `Project`s by default
public enum FileType : String, CaseIterable {
    /// A PNG image file
    case png
    /// A JPEG image file
    case jpeg
    /// A GIF image file
    case gif
    /// A TIFF image file
    case tiff
    /// A PDF file
    case pdf
    /// A SVG file
    case svg
    /// A Tiled map in XML format
    case tmx
    /// A Tiled tileset in XML format
    case tsx
    /// A directory
    case directory
    
    /// Returns the standard extension for the `FileType`
    var extensions : [String] {
        switch self {
        case .png:
            return [rawValue, "apng"]
        case .jpeg:
            return [rawValue, "jpg"]
        case .directory:
            return []
        default:
            return [rawValue]
        }
    }
    
    /// `true` if the file type is a directory
    var isDirectory : Bool {
        return self == .directory
    }
    
    /// `true` if the file type is a map file
    var isMap : Bool {
        return self == .tmx
    }
    
    /// `true` if the file type is an image flie
    var isImage : Bool {
        switch self {
        case .png, .jpeg, .gif, .tiff, .pdf, .svg:
            return true
        case .tmx, .tsx, .directory:
            return false
        }
    }
}
