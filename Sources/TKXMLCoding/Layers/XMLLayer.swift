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
    var opacity : Double {get}
    var properties : XMLProperties {get}
    var locked : Bool { get }
    var tintColor : String? { get }
}

struct XMLLayerCommon : Codable{
    let id: Int
    let _name : String?
    var name : String {
        return _name ?? ""
    }
    let offsetx : Double?
    let offsety : Double?
    let visible : Bool?
    let opacity : Double?
    let locked  : Bool?
    let tintColor : String?
        
    enum CodingKeys : String, CodingKey {
        case id, _name="name", offsetx, offsety, visible, opacity, locked, tintColor = "tintcolor"
    }
}

