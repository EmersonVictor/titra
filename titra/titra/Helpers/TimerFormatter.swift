//
//  TimerFormatter.swift
//  titra
//
//  Created by Emerson Victor on 28/02/19.
//  Copyright © 2019 evfl. All rights reserved.
//

import Foundation
import UIKit

struct TimerFormatter {
    static func format(_ sec: Int32, toUnits unist: NSCalendar.Unit, withStyle style: DateComponentsFormatter.UnitsStyle = .abbreviated) -> String {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = unist
        formatter.unitsStyle = style
        
        let formattedString = formatter.string(from: TimeInterval(sec))!
        
        return formattedString
    }
}
