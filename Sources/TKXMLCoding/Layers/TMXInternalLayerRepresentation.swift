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

public protocol TMXLayer {
    var id : Int { get }
    var name : String { get }

}

protocol TMXInternalLayerRepresentation : Codable, TMXLayer {
    var id : Int { get }
    var name : String { get }
    
    var xoffset : Double? { get }
    var yoffset : Double? { get }
    var visible : Bool? { get }
}

public extension TMXLayer {
    var x : Double {
        return (self as? TMXInternalLayerRepresentation)?.xoffset ?? 0
    }
    
    var y : Double {
        return (self as? TMXInternalLayerRepresentation)?.yoffset ?? 0
    }
    
    var show : Bool {
        return (self as? TMXInternalLayerRepresentation)?.visible ?? true
    }
}
