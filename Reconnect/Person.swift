//
//  Person.swift
//  Contact Reconnect
//
//  Created by ari kurniawan on 06/02/19.
//  Copyright © 2019 ari kurniawan. All rights reserved.
//

import Foundation
import UIKit

enum Periode {
    case oneMonth
    case sixMonth
    case oneYear
    case skipped
    case notIntroduced
}

struct Person {
    var identifier: String?
    var name: String
    var jobTitle: String?
    var image: UIImage?
    var periode: Periode
    var lastContact: Date?
    var nextContact: Date?

    init(name: String, jobTitle: String? = nil, image: UIImage? = nil, periode: Periode = .notIntroduced, lastContact: Date = Date(), nextContact: Date = Date()) {
        self.name = name
        self.jobTitle = jobTitle
        self.image = image
        self.periode = periode
        self.lastContact = lastContact
        self.nextContact = nextContact
    }
}
