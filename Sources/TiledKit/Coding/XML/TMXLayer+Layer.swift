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

extension XMLLayer {
    var location : Location {
        return Location(x: x, y: y)
    }
    
    #warning("Does not produce specialised layers yet")
    var tkLayer : TKLayer? {
        if let tileLayer = self as? TMXTileLayer {
            return TKLayer(name: tileLayer.name, visible: tileLayer.visible, opacity: tileLayer.opacity, position: tileLayer.location)
        } else if let objectLayer = self as? XMLObjectLayer {
            return TKLayer(name: objectLayer.name, visible: objectLayer.visible, opacity: objectLayer.opacity, position: objectLayer.location)

        } else if let groupLayer = self as? TMXGroupLayer {
            return TKLayer(name: groupLayer.name, visible: groupLayer.visible, opacity: groupLayer.opacity, position: groupLayer.location)

        } else if let imageLayer = self as? TMXImageLayer {
            return TKLayer(name: imageLayer.name, visible: imageLayer.visible, opacity: imageLayer.opacity, position: imageLayer.location)
        }
        
        return nil
    }
}
