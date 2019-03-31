//
//  FormValidationTests.swift
//  SwiftKatasTests
//
//  Created by Pedro Vicente Gomez on 31/03/2019.
//  Copyright © 2019 Pedro's Lab. All rights reserved.
//

import Foundation
import XCTest
import SwiftCheck
import Bow
import Nimble
@testable import SwiftKatas

class FormValidationSpec: XCTestCase {
    func testDoesNotValidateAnEmptyFormWhereEveryFieldIsWrong() {
        let form = Form(firstName: "",
                        lastName: "  ",
                        birthday: Date(),
                        documentId: "48632500",
                        phoneNumber: "6799",
                        email: "pedro")

        let result = FormValidator.validateForm(Date(), form)

        expect(result).to(equal(Validated<Nel<FormError>, Form>
            .invalid(Nel.init(head: FormError.invalidEmail(form.email), tail: [
                FormError.invalidPhoneNumber(form.phoneNumber),
                FormError.invalidDocumentId(form.documentId),
                FormError.userTooYoung(form.birthday),
                FormError.emptyLastName(form.lastName),
                FormError.emptyFirstName(form.firstName)
                ]))))
    }

    func testDoesNotValidateAFormWhereJustOneFieldIsWrong() {
        let form = Form(firstName: "Pedro",
                        lastName: "Gómez",
                        birthday: Date.init(timeIntervalSince1970: 0),
                        documentId: "48632500C",
                        phoneNumber: "677673298",
                        email: "pedro")

        let result = FormValidator.validateForm(Date(), form)

        expect(result).to(equal(Validated<Nel<FormError>, Form>
            .invalid(Nel.init(head: FormError.invalidEmail(form.email), tail: []))))
    }

    func testProperties() {
        property("every form composed by valid fields should be valid") <-
            forAll { (form: Form) in
                FormValidator.validateForm(Date(), form).isValid
        }
    }
}
