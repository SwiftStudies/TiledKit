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


/// Used to indicate for staggered orientations which axis is staggered
public enum StaggerAxis : String {
    /// Staggered on the x-axis
    case x
    /// Staggered on the y-axis
    case y
    
    /// Creates a new instance 
    /// - Parameter rawValue: The raw value, `nil` will always be the result if `nil` is supplied
    public init?(_ rawValue:String?){
        guard let rawValue = rawValue else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}

/// Used to indicate for staggered orientations if even or odd indexs are staggered
public enum StaggerIndex : String {
    /// Odd indexes are staggered
    case odd
    
    /// Even indexes are staggered
    case even

    /// Creates a new instance 
    /// - Parameter rawValue: The raw value, `nil` will always be the result if `nil` is supplied
    public init?(_ rawValue:String?){
        guard let rawValue = rawValue else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
    
    public func appliesTo(_ index:Int)->Bool{
        switch self {
        case .even:
            return index.isMultiple(of: 2)
        case .odd:
            return !index.isMultiple(of: 2)
        }
    }
}
