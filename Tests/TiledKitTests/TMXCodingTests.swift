import XCTest

@testable import TKCoding
import XMLCoder
import TiledResources

final class TMXCodingTests: XCTestCase {
    
    fileprivate enum TestError : Error {
        case message(String)
    }
    
    func testProjectFile(){
        let project : JSONProject
        do {
            project = try JSONProject(from: TiledResources.GenericTiledProject.projectFile.url)
        } catch {
            return XCTFail("Error loading \(error)")
        }
        
        XCTAssertEqual(project.objectTypesFile, "Object Types.xml")
        XCTAssertEqual(project.extensionsPath, "extensions")
        XCTAssertEqual(project.automappingRulesFile, "")
        XCTAssertEqual(project.commands.count, 1)
        XCTAssertEqual(project.folders.count, 3)
        XCTAssertEqual(project.folders[0], "Images")
        XCTAssertEqual(project.folders[1], "Maps")
    }
    
    func testObjectTypesFile() {
        let objectTypes : XMLObjectTypes
        do {
            objectTypes = try XMLObjectTypes(from: TiledResources.GenericTiledProject.objectTypesFile.url)
        } catch {
            return XCTFail("Error loading \(error)")
        }
        
        XCTAssertEqual(objectTypes.types.count, 1)
        
        let objectType = objectTypes.types[0]
        
        XCTAssertEqual(objectType.name, "Object Type")
        XCTAssertEqual(objectType.color, "#fd6fcf")
        
        let properties = objectType.properties
        
        XCTAssertEqual(properties[0].name, "Bool")
        XCTAssertEqual(properties[0].type, "bool")
        XCTAssertEqual(properties[0].default, "true")

        XCTAssertEqual(properties[10].name, "String Unset")
        XCTAssertEqual(properties[10].type, "string")
        XCTAssertEqual(properties[10].default, nil)
    }
    
    func testTMXLevel(){
        let level : TMXMap
        do {
            let data = try Data(contentsOf: TiledResources.GenericTiledProject.Maps.oneOfEverything.url)
            level = try TMXMap.decoder.decode(TMXMap.self, from: data)
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
        XCTAssertEqual(level.tileSetReferences.count, 1)
        XCTAssertEqual(level.tileSetReferences[0].firstGid, 1)
        XCTAssertEqual(level.tileSetReferences[0].path, "../Tilesets/Alphabet.tsx")
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
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: TiledResources.GenericTiledProject.TileSets.alphabet.url))

            XCTAssertEqual(tileSet.tileWidth, 16)
            XCTAssertEqual(tileSet.tileHeight, 16)
            XCTAssertEqual(tileSet.tileCount, 6)
            XCTAssertEqual(tileSet.properties.properties.count, 1)
        
            XCTAssertEqual(tileSet.properties.properties.first?.value, "nearest")
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }
    
    func testSingleImageTileSetWithOptionals(){
        let tileSet : TSXTileSet
        do {
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: TiledResources.GenericTiledProject.TileSets.topDownNoMarginNoSpacing.url))
            XCTAssertEqual(tileSet.tileWidth, 16)
            XCTAssertEqual(tileSet.tileHeight, 16)
            XCTAssertEqual(tileSet.tileCount, 16)
            XCTAssertNotNil(tileSet.image, "Should be a tile sheet")
            XCTAssertNotNil(tileSet.image?.transparentColor ?? "", "ff00ff")
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }

    func testMultiImageTileSetWithSingleTile(){
        let tileSet : TSXTileSet
        do {
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: TiledResources.GenericTiledProject.TileSets.alphabet.url))
            XCTAssertEqual(tileSet.tileWidth, 16)
            XCTAssertEqual(tileSet.tileHeight, 16)
            XCTAssertEqual(tileSet.tileCount, 6)
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }
    
    func testMultiImageTileSet(){
        let tileSet : TSXTileSet
        do {
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: TiledResources.GenericTiledProject.TileSets.alphabet.url))
            XCTAssertEqual(tileSet.tileWidth, 16)
            XCTAssertEqual(tileSet.tileHeight, 16)
            XCTAssertEqual(tileSet.tileCount, 6)
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }

    func testTileSetCollisionObjects(){
        let tileSet : TSXTileSet
        do {
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: TiledResources.GenericTiledProject.TileSets.animation.url))

            if tileSet.tileSpecs.count < 6 {
                return XCTFail("Expected at least one tile")
            }
            
            XCTAssertEqual((tileSet.tileSpecs[4].collisionObject?.objects.count) ?? 0, 1)
            XCTAssertEqual((tileSet.tileSpecs[5].collisionObject?.objects.count) ?? 0, 1)
            XCTAssertEqual((tileSet.tileSpecs[4].collisionObject?.objects[0].x) ?? 0, 3.0)
            XCTAssertEqual((tileSet.tileSpecs[5].collisionObject?.objects[0].y) ?? 0, 3.0)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testTileSetAnimationFrames(){
        let tileSet : TSXTileSet
        do {
            tileSet = try TSXTileSet.decoder.decode(TSXTileSet.self, from:  Data(contentsOf: TiledResources.GenericTiledProject.TileSets.animation.url))

            if tileSet.tileSpecs.count < 6 {
                return XCTFail("Execpted more tiles")
            }
            
            let tile = tileSet.tileSpecs[1]
            
            XCTAssertEqual(tile.animationFrames.count, 4)
            XCTAssertEqual(tile.animationFrames[0].tileid, 4)
            XCTAssertEqual(tile.animationFrames[1].tileid, 5)
            XCTAssertEqual(tile.animationFrames[2].tileid, 6)
            XCTAssertEqual(tile.animationFrames[3].tileid, 7)
            XCTAssertEqual(tile.animationFrames[0].duration, 10000)
            XCTAssertEqual(tile.animationFrames[1].duration, 1000)
            XCTAssertEqual(tile.animationFrames[2].duration, 1000)
            XCTAssertEqual(tile.animationFrames[3].duration, 2000)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testBase64(){
        XCTAssertNoThrow(try TiledResources.GenericTiledProject.Maps.base64.load())
    }
    
    func testBase64zlib(){
//        XCTAssertNoThrow(try TiledResources.GenericTiledProject.Maps.base64zlib.load())        
    }
    
    func testBase64zstandard(){
//        XCTAssertNoThrow(try TiledResources.GenericTiledProject.Maps.base64zstandard.load())          
    }
    
    static var allTests = [
        ("testBase64",testBase64),
        ("testBase64zlib",testBase64zlib),
        ("testBase64zstandard",testBase64zstandard),
        ("testTMXLevel",testTMXLevel),
        ("testMultiImageTileSetWithSingleTile",testMultiImageTileSetWithSingleTile),
        ("testMultiImageTileSet",testMultiImageTileSet),
        ("testSingleImageTileSetWithOptionals", testSingleImageTileSetWithOptionals),
        ("testSingleImageTileSet", testSingleImageTileSet),
        ("testTileSetCollisionObjects", testTileSetCollisionObjects),
        ("testTileSetAnimationFrames", testTileSetAnimationFrames),
        ("testObjectTypesFile", testObjectTypesFile),
        ("testProjectFile",testProjectFile),
        ]
 
}
