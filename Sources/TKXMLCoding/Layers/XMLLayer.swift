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

public protocol XMLLayer : Codable {
    var id : Int { get }
    var name : String { get }
    var x : Double {get}
    var y : Double {get}
    var visible: Bool {get}

}

struct XMLLayerCommon : Codable{
    let id: Int
    let name : String
    let xoffset : Double?
    let yoffset : Double?
    let visible : Bool?
    
}

