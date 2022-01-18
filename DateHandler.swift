//
//  DateHandler.swift
//  BGNetworkingTestApp
//
//  Created by Emily Corso on 1/17/22.
//

import Foundation

struct DateHandler {
    static let dateInputFormat = "MMM d, yyyy HH:mm"
    static let dateOutputFormat = "MMM d h:mm a"
    let formatter: DateFormatter
    
    init() {
        // default init assumes this is input for parsing the date format of a string
        formatter = DateFormatter(format: DateHandler.dateInputFormat)
    }
    
    init(format: String) {
        // alt init allows the user to specify the format, in case there are multiple output formats in the future
        formatter = DateFormatter(format: format)
    }
}
