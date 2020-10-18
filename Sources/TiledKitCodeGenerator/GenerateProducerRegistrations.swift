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

fileprivate var closed = Set<Set<ProducerType>>()

fileprivate func registrationFunction(forProducerConformingTo conformances:Set<ProducerType>, into output: inout String){
    guard !closed.contains(conformances) else {
        return
    }
    
    closed.insert(conformances)
    
    output.print("""
        \t/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
        \t/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
        """)
    
    var declaration = "\tstatic func register<Producer>(producer:Producer) where Producer.EngineType == Self"
    for conformance in conformances {
        declaration += ", Producer: \(conformance.name)"
    }
    output.print(declaration+" {")
    for conformance in conformances {
        output.print("\t\tEngineRegistry.insert(for: Self.self, object: \(conformance.wrapperType)(wrap: producer))")
    }
    output.print("\t}\n")
}

fileprivate func elaborate(conformingTo producers:Set<ProducerType>, with otherProducers:Set<ProducerType>, into output:inout String){
    registrationFunction(forProducerConformingTo:producers, into: &output)
    
    for otherProducer in otherProducers {
        var additionalConformances = producers
        additionalConformances.insert(otherProducer)
        elaborate(conformingTo: additionalConformances, with: otherProducers.removing(otherProducer), into: &output)
    }
}

func generateProducerRegistrationFunctions(for allProducers:Set<ProducerType>)->String{
    var output = """
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
        
        """
    output.print("/// Adds support for adding `PostProcessor`s and `Factories` that support multiple types")
    output.print("public extension Engine {")
    for producer in allProducers {
        elaborate(conformingTo: [producer], with: allProducers, into: &output)
    }
    output.print("}")
    
    return output
}
