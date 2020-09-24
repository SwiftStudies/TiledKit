import XCTest

@testable import TKXMLCoding
import XMLCoder

final class TMXCodingTests: XCTestCase {
    
    fileprivate enum TestError : Error {
        case message(String)
    }
    
    func testTMXLevel(){
        let level : TMXLevel
        do {
            guard let url = Bundle.module.url(forResource: "One of Everything", withExtension: "tmx", subdirectory: "Maps") else {
                XCTFail("Could not find map")
                return
            }
            let data = try Data(contentsOf: url)
            level = try TMXLevel.decoder.decode(TMXLevel.self, from: data)
        } catch {
            XCTFail("Error loading \(error)")
            return
        }
        
        XCTAssertEqual(level.version, "1.4")
        XCTAssertEqual(level.tiledVersion, "1.4.2")
        XCTAssertEqual(level.orientation, "orthogonal")
        XCTAssertEqual(level.renderOrder, "right-down")
        XCTAssertEqual(level.width, 10)
        XCTAssertEqual(level.height, 10)
        XCTAssertEqual(level.tileWidth, 16)
        XCTAssertEqual(level.tileHeight, 16)
        XCTAssertEqual(level.infinite, false)
        XCTAssertEqual(level.layers.count, 4)
        XCTAssertEqual(level.tileSetReferences.count, 2)
        XCTAssertEqual(level.tileSetReferences[0].firstGid, 1)
        XCTAssertEqual(level.tileSetReferences[0].path, "../Tilesets/SeparateSingleImage.tsx")
        XCTAssertEqual(level.tileSetReferences[1].firstGid, 2)
        XCTAssertEqual(level.tileSetReferences[1].path, "../Tilesets/Animation.tsx")
        XCTAssertEqual(level.layers.count, 4)
        XCTAssertTrue(level.layers[0] is TMXTileLayer)
        XCTAssertTrue(level.layers[1] is XMLObjectLayer)
        XCTAssertTrue(level.layers[2] is TMXImageLayer)
        XCTAssertTrue(level.layers[3] is TMXGroupLayer)
        XCTAssertEqual(level.properties.properties.count, 7)
        
        if let objectLayer = level.layers[1] as? XMLObjectLayer {
            XCTAssertEqual(2, objectLayer.id)
            XCTAssertEqual("Object Layer", objectLayer.name)
            XCTAssertEqual(16, objectLayer.x)
            XCTAssertEqual(16, objectLayer.y)
            XCTAssertEqual(7, objectLayer.objects.count)
            XCTAssertEqual(1, objectLayer.objects[0].properties.properties.count)
            XCTAssertEqual("strokeColor", objectLayer.objects[0].properties.properties[0].name)
            XCTAssertEqual("color", objectLayer.objects[0].properties.properties[0].type!.rawValue)
            XCTAssertEqual("#ffff0000", objectLayer.objects[0].properties.properties[0].value)
        } else {
            XCTFail("Expected layer to be object layer")
        }
    }
    
    func testSingleImageTileSet(){
        let tileSet : TSXTileSet
        do {
            guard let url = Bundle.module.url(forResource: "SingleImageAutoTransparency", withExtension: "tsx", subdirectory: "Tilesets") else {
                XCTFail("Could not find TileSet in bundle")
                return
            }
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: url))

            XCTAssertEqual(tileSet.tileWidth, 16)
            XCTAssertEqual(tileSet.tileHeight, 16)
            XCTAssertEqual(tileSet.tileCount, 4)
            XCTAssertEqual(tileSet.properties.properties.count, 1)
        
            XCTAssertEqual(tileSet.properties.properties[0].value, "nearest")
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }
    
    func testSingleImageTileSetWithOptionals(){
        let tileSet : TSXTileSet
        do {
            guard let url = Bundle.module.url(forResource: "SingleImageMarginsAndSpacing", withExtension: "tsx", subdirectory: "Tilesets") else {
                XCTFail("Could not find TileSet in bundle")
                return
            }
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: url))
            XCTAssertEqual(tileSet.tileWidth, 12)
            XCTAssertEqual(tileSet.tileHeight, 12)
            XCTAssertEqual(tileSet.tileCount, 4)
            XCTAssertNotNil(tileSet.image, "Should be a tile sheet")
            XCTAssertNotNil(tileSet.image?.transparentColor ?? "", "ff00ff")
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }

    func testMultiImageTileSetWithSingleTile(){
        let tileSet : TSXTileSet
        do {
            guard let url = Bundle.module.url(forResource: "SeparateSingleImage", withExtension: "tsx", subdirectory: "Tilesets") else {
                XCTFail("Could not find TileSet in bundle")
                return
            }
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: url))
            XCTAssertEqual(tileSet.tileWidth, 16)
            XCTAssertEqual(tileSet.tileHeight, 16)
            XCTAssertEqual(tileSet.tileCount, 1)
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }
    
    func testMultiImageTileSet(){
        let tileSet : TSXTileSet
        do {
            guard let url = Bundle.module.url(forResource: "SeparateMultipleImages", withExtension: "tsx", subdirectory: "Tilesets") else {
                XCTFail("Could not find TileSet in bundle")
                return
            }
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: url))
            XCTAssertEqual(tileSet.tileWidth, 16)
            XCTAssertEqual(tileSet.tileHeight, 16)
            XCTAssertEqual(tileSet.tileCount, 2)
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }

    func testTileSetCollisionObjects(){
        let tileSet : TSXTileSet
        do {
            guard let url = Bundle.module.url(forResource: "Animation", withExtension: "tsx", subdirectory: "Tilesets") else {
                XCTFail("Could not find TileSet in bundle")
                return
            }
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: url))

            XCTAssertEqual((tileSet.tileSpecs[0].collisionObject?.objects.count) ?? 0, 2)
            XCTAssertEqual((tileSet.tileSpecs[0].collisionObject?.objects[0].x) ?? 0, 7.92176)
            XCTAssertEqual((tileSet.tileSpecs[0].collisionObject?.objects[1].y) ?? 0, 3.00272)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testTileSetAnimationFrames(){
        let tileSet : TSXTileSet
        do {
            guard let url = Bundle.module.url(forResource: "Animation", withExtension: "tsx", subdirectory: "Tilesets") else {
                XCTFail("Could not find TileSet in bundle")
                return
            }
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: url))

            let tile = tileSet.tileSpecs[1]
            
            XCTAssertEqual(tile.animationFrames.count, 4)
            XCTAssertEqual(tile.animationFrames[0].tileid, 0)
            XCTAssertEqual(tile.animationFrames[1].tileid, 1)
            XCTAssertEqual(tile.animationFrames[2].tileid, 2)
            XCTAssertEqual(tile.animationFrames[3].tileid, 3)
            XCTAssertEqual(tile.animationFrames[0].duration, 1000)
            XCTAssertEqual(tile.animationFrames[1].duration, 1000)
            XCTAssertEqual(tile.animationFrames[2].duration, 1000)
            XCTAssertEqual(tile.animationFrames[3].duration, 1000)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    static var allTests = [
        ("testTMXLevel",testTMXLevel),
        ("testMultiImageTileSetWithSingleTile",testMultiImageTileSetWithSingleTile),
        ("testMultiImageTileSet",testMultiImageTileSet),
        ("testSingleImageTileSetWithOptionals", testSingleImageTileSetWithOptionals),
        ("testSingleImageTileSet", testSingleImageTileSet),
        ("testTileSetCollisionObjects", testTileSetCollisionObjects),
        ("testTileSetAnimationFrames", testTileSetAnimationFrames),

        ]
 
}
