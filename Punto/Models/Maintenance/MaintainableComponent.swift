//
//  MaintainableComponent.swift
//  Punto
//
//  Created by Sebastian Garcia on 20/02/26.
//

import Foundation
// define some basic part (oil, breaks, liquido refrigerante, tires, oil filter)

struct MaintainableComponent {
    // Name of the part, Ex: Breaks, Tires, Oil, etc
    var componentName: String
    // Input to the user set the last maintenance and the Travel mesurment  in that day
    var lastTimeMaintainedInformation: (Date, Int)
    // Range unity of useful life of the component
    var rangeOfUsefulLife: ClosedRange<Int>
    // Range date of useful life of the component
    var rangeDateOfUsefulLife: ClosedRange<Date>
}
 


