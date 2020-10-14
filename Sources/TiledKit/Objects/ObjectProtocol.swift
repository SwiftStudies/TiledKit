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

public protocol ObjectProtocol : Propertied {
    /// An identifier for an `Object` that is unique with the `Map`
    var id      : Int {get}
    
    /// The name of the `Object`, or an empty `String`
    var name    : String {get}
    
    /// The type of the object
    var type    : String? {get}
    
    /// `true` if the `Object` should be rendered
    var visible : Bool {get}
    
    /// The location of the `Object` relative to its containing `Layer`
    var position: Position {get}
}
