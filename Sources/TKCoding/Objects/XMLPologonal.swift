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

public typealias XMLPoints = [(x:Double, y:Double)]

public struct XMLPologonal : Codable {
    private let _points : String
    
    enum CodingKeys : String, CodingKey {
        case _points = "points"
    }
    
    public var points : XMLPoints {
        return _points.split(separator: " ").map(){
            let xy = $0.split(separator: ",")
            
            return (x:Double(xy[0]) ?? 0, y:Double(xy[1]) ?? 0)
        }
    }
}
