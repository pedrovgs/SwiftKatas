//
//  ArbitraryForm.swift
//  SwiftKatasTests
//
//  Created by Pedro Vicente Gomez on 31/03/2019.
//  Copyright © 2019 Pedro's Lab. All rights reserved.
//

import Foundation
import SwiftCheck
@testable import SwiftKatas

extension Form: Arbitrary {
    private static let arbitraryNonEmptyString = String.arbitrary.suchThat { (s) -> Bool in
        !s.isEmpty
    }

    private static let arbitrary8DigitsString = Gen.choose((10000000, 99999999)).map { (number) -> String in
        "\(number)"
    }

    private static let arbitraryDocumentId = Form.arbitrary8DigitsString.map { (firstPart) -> String in
        "\(firstPart)\(arbitraryChar)"
    }

    private static let arbitraryChar = Character.arbitrary.suchThat({ (char) -> Bool in
        char >= "A" && char <= "Z"
    }).map { (char) -> String in
        "\(char)"
    }

    private static let arbitrary9DigitsString = Gen.choose((100000000, 999999999)).map { (number) -> String in
        "\(number)"
    }

    private static let arbitraryEmail = arbitraryNonEmptyString.map { (firstPart) -> String in
        "\(firstPart)@\(Form.arbitraryNonEmptyString.generate)"
    }

    public static var arbitrary: Gen<Form> {
        return arbitraryNonEmptyString.map({ (firstName) -> Form in
            Form(firstName: firstName,
                 lastName: arbitraryNonEmptyString.generate,
                 birthday: Date.init(timeIntervalSince1970: 1),
                 documentId: "\(arbitrary8DigitsString.generate)\(arbitraryChar.generate)",
                 phoneNumber: arbitrary9DigitsString.generate,
                 email: arbitraryEmail.generate)
        })
    }
}
