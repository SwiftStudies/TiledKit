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

public struct JSONProject : Codable {
    public let automappingRulesFile : String?
    public let extensionsPath : String?
    public let folders : [String]
    public let objectTypesFile : String?
    
    public let commands : [JSONCommand]
    
    
    public init(from url:URL) throws {
        let data = try Data(contentsOf: url)
        
        let loaded = try JSONDecoder().decode(JSONProject.self, from: data)
        
        automappingRulesFile = loaded.automappingRulesFile
        extensionsPath = loaded.extensionsPath
        folders = loaded.folders
        objectTypesFile = loaded.objectTypesFile
        commands = loaded.commands
    }
}
