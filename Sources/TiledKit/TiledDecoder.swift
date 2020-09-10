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
import XMLCoder

internal class TiledDecoder : XMLDecoder {
    let decodingContext : DecodingContext
    init(from url: URL) {
        let url = url.deletingLastPathComponent()
        decodingContext = DecodingContext(originatingFrom: url)
        super.init()
        
        userInfo[DecodingContext.key] = decodingContext
    }
}

public enum TiledDecodingError : Error {
    case missingDecoderContext
    case noContainerForLayer(layerPath:[Layer])
    case couldNotLoadFile(url:URL, message:String)
    case couldNotLoadLevel(url:URL, decodingError:Error)
    case couldNotLoadTileSet(url:URL, decodingError:Error)
    case objectNotContainedInObjectLayer(layerPath:[Layer])
}
