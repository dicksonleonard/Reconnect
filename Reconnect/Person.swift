//
//  Person.swift
//  Contact Reconnect
//
//  Created by ari kurniawan on 06/02/19.
//  Copyright © 2019 ari kurniawan. All rights reserved.
//

import Foundation
import UIKit

enum Periode: String, CaseIterable {
    case oneMonth = "One Month"
    case sixMonth = "Six Month"
    case oneYear = "One Year"
    case skipped = "Skipped"
    case notIntroduced = "Not Introduced"
}

struct Person {
    var identifier: String?
    var name: String
    var lastName: String
    var jobTitle: String?
    var image: UIImage?
    var periode: Periode
    var lastContact: Date?
    var nextContact: Date?


    init(name: String, lastName: String = "", jobTitle: String? = nil, image: UIImage? = nil, periode: Periode = .notIntroduced, lastContact: Date = Date(), nextContact: Date = Date(), mobileNumber:String? = "", email: String? = "", personalNotes: String? = nil) {
        self.name = name
        self.lastName = lastName
        self.jobTitle = jobTitle
        self.image = image
        self.periode = periode
        self.lastContact = lastContact
        self.nextContact = nextContact
    }
}
