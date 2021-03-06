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

import TKCoding
import Foundation

extension XMLLayer {
    var location : Position {
        return Position(x: x, y: y)
    }
    
    func tkLayer(for map:Map, in project:Project) -> Layer? {
        if let tileLayer = self as? TMXTileLayer {
            let grid = tileLayer.tileGrid(for: map)
            return Layer(name: tileLayer.name, visible: tileLayer.visible, opacity: tileLayer.opacity, position: tileLayer.location, kind: .tile(grid), locked: tileLayer.locked, tintColor: Color(from: tileLayer.tintColor),properties: tileLayer.properties.interpret(baseUrl: map.url, in: project))
        } else if let objectLayer = self as? XMLObjectLayer {
            let objects = objectLayer.objects.map({$0.tkObject(for: map, in: project)})
            return Layer(name: objectLayer.name, visible: objectLayer.visible, opacity: objectLayer.opacity, position: objectLayer.location, kind: .objects(objects), locked: objectLayer.locked, tintColor: Color(from: objectLayer.tintColor), properties: objectLayer.properties.interpret(baseUrl: map.url, in: project))
        } else if let groupLayer = self as? TMXGroupLayer {
            let group = Group(layers: groupLayer.layers.compactMap({$0.tkLayer(for:map, in: project)}))
            return Layer(name: groupLayer.name, visible: groupLayer.visible, opacity: groupLayer.opacity, position: groupLayer.location, kind: .group(group), locked: groupLayer.locked, tintColor: Color(from: groupLayer.tintColor), properties: groupLayer.properties.interpret(baseUrl: map.url, in: project))
        } else if let imageLayer = self as? TMXImageLayer {
            let image = imageLayer.tkImage(in: project, relativeTo: map.url)
            return Layer(name: imageLayer.name, visible: imageLayer.visible, opacity: imageLayer.opacity, position: imageLayer.location, kind: .image(image), locked: imageLayer.locked, tintColor: Color(from: imageLayer.tintColor), properties: imageLayer.properties.interpret(baseUrl: map.url, in: project))
        }
        
        return nil
    }
}

extension TMXImageLayer {
    func tkImage(in project:Project, relativeTo url: URL?)->ImageReference{
        let url = project.resolve(URL(fileURLWithPath: path), relativeTo:url) ?? URL(fileURLWithPath: path)
        
        return ImageReference(source: url, size: PixelSize(width: width, height: height))
    }
}
