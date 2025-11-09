//
//  DoubleExtensions.swift
//  MoonPi
//
//  Created by Gabriel Santos on 2/11/25.
//

import Foundation

private var durationFormatter: DateComponentsFormatter {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = [.pad]
    return formatter
}

extension Double {
    var timeString: String {
        return durationFormatter.string(from: TimeInterval(self)) ?? "00:00"
    }
}
