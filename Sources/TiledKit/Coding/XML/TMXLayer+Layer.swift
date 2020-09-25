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

extension XMLLayer {
    var location : Location {
        return Location(x: x, y: y)
    }
    
    func tkLayer(for map:Map, in project:Project) -> TKLayer? {
        if let tileLayer = self as? TMXTileLayer {
            let grid = tileLayer.tileGrid(for: map)
            return TKLayer(name: tileLayer.name, visible: tileLayer.visible, opacity: tileLayer.opacity, position: tileLayer.location, kind: .tile(grid), properties: tileLayer.properties.interpret(for: map, in: project))
        } else if let objectLayer = self as? XMLObjectLayer {
            let objects = objectLayer.objects.map({$0.tkObject(for: map, in: project)})
            return TKLayer(name: objectLayer.name, visible: objectLayer.visible, opacity: objectLayer.opacity, position: objectLayer.location, kind: .objects(objects), properties: objectLayer.properties.interpret(for: map, in: project))
        } else if let groupLayer = self as? TMXGroupLayer {
            let group = Group(layers: groupLayer.layers.compactMap({$0.tkLayer(for:map, in: project)}))
            return TKLayer(name: groupLayer.name, visible: groupLayer.visible, opacity: groupLayer.opacity, position: groupLayer.location, kind: .group(group), properties: groupLayer.properties.interpret(for: map, in: project))
        } else if let imageLayer = self as? TMXImageLayer {
            let image = imageLayer.tkImage(in: project, relativeTo: map.url)
            return TKLayer(name: imageLayer.name, visible: imageLayer.visible, opacity: imageLayer.opacity, position: imageLayer.location, kind: .image(image), properties: imageLayer.properties.interpret(for: map, in: project))
        }
        
        return nil
    }
}

extension TMXImageLayer {
    func tkImage(in project:Project, relativeTo url: URL?)->TKImage{
        let url = project.url(for: URL(fileURLWithPath: path), relativeTo:url) ?? URL(fileURLWithPath: path)
        
        return TKImage(url: url, size: PixelSize(width: width, height: height))
    }
}
