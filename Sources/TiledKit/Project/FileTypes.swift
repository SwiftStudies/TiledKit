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

public enum FileTypes : String, CaseIterable {
    case png, jpeg, gif, tiff, pdf, svg, tmx, tsx, directory
    
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
    
    var isDirectory : Bool {
        return self == .directory
    }
    
    var isImage : Bool {
        switch self {
        case .png, .jpeg, .gif, .tiff, .pdf, .svg:
            return true
        case .tmx, .tsx:
            return false
        }
    }
}
