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

import TKXMLCoding
import Foundation


extension XMLPoints {
    var path : Path {
        return map({Position(x: $0.x, y: $0.y)})
    }
}

extension XMLObject {
    var location : Position {
        return Position(x: x, y: y)
    }

    func tkGeometricObject(relativeTo baseUrl:URL?, in project:Project) -> Object? {
        switch type {
        case .point:
            return Object(id: id, name: name, visible: visible, position: location, properties: properties.interpret(baseUrl: baseUrl, in: project), kind: .point)
        case .rectangle(let size, let rotation):
            return Object(id: id, name: name, visible: visible, position: location, properties: properties.interpret(baseUrl: baseUrl, in: project), kind: .rectangle(Size(width: size.width, height: size.height), angle: rotation))
        case .elipse(let size, let rotation):
            return Object(id: id, name: name, visible: visible, position: location, properties: properties.interpret(baseUrl: baseUrl, in: project), kind: .ellipse(Size(width: size.width, height: size.height), angle: rotation))
        case .polyline(let path, let rotation):
            return Object(id: id, name: name, visible: visible, position: location, properties: properties.interpret(baseUrl: baseUrl, in: project), kind: .polyline(path.points.path, angle: rotation))
        case .polygon(let path, let rotation):
            return Object(id: id, name: name, visible: visible, position: location, properties: properties.interpret(baseUrl: baseUrl, in: project), kind: .polygon(path.points.path, angle: rotation))
        default:
            return nil
        }
    }
    
    func tkObject(for map:Map, in project:Project)->Object {
        switch type {
        case .point, .rectangle, .elipse, .polyline, .polygon:
            return tkGeometricObject(relativeTo: map.url, in: project)!
        case .tile(let rawTileGid,let size, let rotation):
            return Object(id: id, name: name, visible: visible, position: location, properties: properties.interpret(baseUrl: map.url, in: project), kind: .tile(TileGID(integerLiteral: rawTileGid), size:Size(width: size.width, height: size.height),  angle: rotation))
        case .text(let style, let size, let rotation):
            return Object(id: id, name: name, visible: visible, position: location, properties: properties.interpret(baseUrl: map.url, in: project), kind: .text( style.string, size:Size(width: size.width, height: size.height), angle: rotation, style: style.textStyle))
        }
    }
}
