//
//  ClassDate.swift
//  BGNetworkingTestApp
//
//  Created by Emily Corso on 1/17/22.
//

import Foundation

class ClassDate {
    // exactDate should eventually be passed into a DateFormatter()
    var exactDate: String?
    var classes: [MbaClass] = [MbaClass]()
}

extension ClassDate: Comparable {
    static func < (lhs: ClassDate, rhs: ClassDate) -> Bool {
        let time = "00:00"
        let lhsFulldate = lhs.exactDate! + " \(time)"
        let rhsFulldate = rhs.exactDate! + " \(time)"
        if let leftDate = lhsFulldate.toDate(), let rightDate = rhsFulldate.toDate() {
            return leftDate < rightDate
        } else {
            return false
        }
    }
    
    static func == (lhs: ClassDate, rhs: ClassDate) -> Bool {
        let time = "00:00"
        let lhsFulldate = lhs.exactDate! + " \(time)"
        let rhsFulldate = rhs.exactDate! + " \(time)"
        if let leftDate = lhsFulldate.toDate(), let rightDate = rhsFulldate.toDate() {
            return leftDate == rightDate
        } else {
            return false
        }
    }
}
