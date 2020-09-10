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

public extension Data {
    static func withContentsInBundleFirst(url:URL) throws ->Data {
        let data : Data

        let fileExtension = url.pathExtension
        let bundleURL = url.lastPathComponent.replacingOccurrences(of: ".\(fileExtension)", with: "")
        
        if let bundleUrl = Bundle.main.url(forResource: bundleURL, withExtension: fileExtension){
            guard let bundleData = try? Data(contentsOf: bundleUrl) else {
                throw TiledDecodingError.couldNotLoadFile(url: url, message: "Could not load bundle resource as data")
            }
            data = bundleData
        } else {
            do {
                return try Data(contentsOf: url)
            } catch {
                throw TiledDecodingError.couldNotLoadFile(url: url, message: "Could not load data \(error)")
            }
        }
        
        return data
    }
}
