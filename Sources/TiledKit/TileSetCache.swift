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

fileprivate struct TileSetNameOnly : Decodable {
    let name : String
}

enum TileSetCache {
    static var fileTileSetMap   = [URL : TileSet]()
    static var cache            = [Identifier : TileSet]()
    
    
    static func tileSet(from tileSetReference:TileSetReference) throws ->TileSet {
        if let identifier = tileSetReference.identifier, let cachedSet = cache[identifier] {
            return cachedSet
        }
        
        let identifier : Identifier!
        
        // Always update the identifier to make subseuence look-ups more efficient
        defer {
            tileSetReference.identifier = identifier
        }
        
        //Try finding it in the cache by its URL
        let url = URL(fileURLWithPath: tileSetReference.file).standardizedFileURL
        if let tileSet = TileSetCache.fileTileSetMap[url] {
            identifier = Identifier(stringLiteral: tileSet.name)
            return tileSet
        }
        
        // Try finding it in the cache by its tileset name which at this point means loading it
        let tileSetName = try! XMLDecoder().decode(TileSetNameOnly.self, from: Data.withContentsInBundleFirst(url:url)).name
        identifier = Identifier(stringLiteral: tileSetName)
        if let cachedWithSameName = cache[Identifier(stringLiteral: tileSetName)] {
            return cachedWithSameName
        }
        
        let newTileSet = try TileSet(from: url)
        
        fileTileSetMap[url] = newTileSet
        cache[identifier] = newTileSet
        
        return newTileSet
    }
    
    static func tileSet(named name:String)->TileSet?{
        return cache[Identifier(stringLiteral: name)]
    }
}
