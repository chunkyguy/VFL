//
//  VFLExample.swift
//  VFLRunner
//
//  Created by Sidharth Juyal on 31/12/2022.
//

import Foundation

struct VFLExample {
    let name: String
    let viewCount: Int
    let description: VFLDescription
}

struct VFLExamples {
    static var all: [VFLExample] {
        return [
            VFLExample(
                name: "Screen Full Layout",
                viewCount: 1,
                description: VFLDescription(formats: [
                    "V:|[vw]|", "H:|[vw]|"
                ])
            ),
            
            VFLExample(
                name: "Horizontal Equal Split",
                viewCount: 2,
                description: VFLDescription(formats: [
                    "V:|[vw0]|",
                    "V:|[vw1]|",
                    "H:|[vw0(==vw1)][vw1]|"
                ])
            ),
            
            VFLExample(
                name: "Vertical Equal Split",
                viewCount: 2,
                description: VFLDescription(formats: [
                    "V:|[vw0(==vw1)][vw1]|",
                    "H:|[vw0]|",
                    "H:|[vw1]|"
                ])
            ),

            VFLExample(
                name: "Fixed Size View",
                viewCount: 1,
                description: VFLDescription(formats: [
                    "V:|-[vw(100)]",
                    "H:|-[vw(100)]"
                ])
            )
        ]
    }
}
