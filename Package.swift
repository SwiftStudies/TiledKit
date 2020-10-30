// swift-tools-version:5.3
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

import PackageDescription

let package = Package(
    name: "TiledKit",
    products: [
        .library(name: "TiledKit", targets: ["TiledKit"]),
        .library(name: "Inflate", targets: ["Inflate"]),
        .executable(name: "tkcodegen", targets: ["TiledKitCodeGenerator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/MaxDesiatov/XMLCoder.git", from: "0.11.1"),
        .package(url: "https://github.com/SwiftStudies/TiledResources.git",from: "0.1.0"),
    ],
    targets: [
        .systemLibrary(
            name: "swiftZLib",
            path: "Sources/swiftZLib",
            pkgConfig: "swiftzlib",
            providers: [
                .apt(["libz-dev"])
            ]
        ), 
        .target(
            name: "TiledKit",
            dependencies: ["TKCoding","Inflate","swiftZLib"]
            ),
        .target(
            name: "TiledKitCodeGenerator",
            dependencies: []
        ),
        .target(
            name: "Inflate",
            dependencies: ["swiftZLib"]
        ),
        .testTarget(
            name: "TiledKitTests",
            dependencies: ["TiledKit","TiledResources","Inflate"]
            ),
        .target(
            name: "TKCoding",
            dependencies: ["XMLCoder","Inflate"]
            ),
    ]
)
