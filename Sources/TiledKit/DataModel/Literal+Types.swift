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

public extension String {
    init?(_ value:Literal?){
        guard let value = value else {
            return nil
        }
        switch value {
        case .string(let value):
            self = value
        default:
            return nil
        }
    }
}

public extension Int {
    init?(_ value:Literal?){
        guard let value = value else {
            return nil
        }
        if case Literal.int(let intValue) = value {
            self = intValue
        } else {
            return nil
        }
    }
}

public extension Bool {
    init?(_ value:Literal?){
        guard let value = value else {
            return nil
        }
        if case Literal.bool(let actualValue) = value {
            self = actualValue
        } else {
            return nil
        }
    }
}

public extension Float {
    init?(_ value:Literal?){
        guard let value = value else {
            return nil
        }
        if case Literal.float(let actualValue) = value {
            self = actualValue
        } else {
            return nil
        }
    }
}

public extension URL {
    init?(_ value:Literal?){
        guard let value = value else {
            return nil
        }
        if case Literal.file(let actualValue) = value {
            self = actualValue
        } else {
            return nil
        }
    }
}


