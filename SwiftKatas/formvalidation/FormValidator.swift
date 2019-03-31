//
//  FormValidator.swift
//  SwiftKatas
//
//  Created by Pedro Vicente Gomez on 30/03/2019.
//  Copyright © 2019 Pedro's Lab. All rights reserved.
//

import Foundation
import Bow

// As we don't have NonEmptyArray we can't use ValidatedNEA in Bow 0.3.0
private typealias FormValidationResult<T> = ValidatedOf<NonEmptyListOf<FormError>, T>

struct Form: Equatable {
    let firstName: String
    let lastName: String
    let birthday: Date
    let documentId: String
    let phoneNumber: String
    let email: String
}

enum FormError: Equatable {
    case emptyFirstName(_ firstName: String)
    case emptyLastName(_ firstName: String)
    case userTooYoung(_ birthday: Date)
    case invalidDocumentId(_ documentId: String)
    case invalidPhoneNumber(_ phoneNumber: String)
    case invalidEmail(_ email: String)
}

class FormValidator {
    static func validateForm(_ referenceDate: Date, _ form: Form) -> Validated<NonEmptyList<FormError>, Form> {
        let validation = Validated<NonEmptyListOf<FormError>, Form>
            .applicative(Nel<FormError>.semigroup())
            .map(validateFirstName(form.firstName),
                 validateLastName(form.lastName),
                 validateBirthday(referenceDate, form.birthday),
                 validateDocumentId(form.documentId),
                 validatePhoneNumber(form.phoneNumber),
                 validateEmail(form.email)) {
                    (firstName,
                    lastName,
                    birthday,
                    documentId,
                    phone,
                    email) -> Form in
                    Form(firstName: firstName,
                         lastName: lastName,
                         birthday: birthday,
                         documentId: documentId,
                         phoneNumber: phone,
                         email: email)
        }
        return (validation as! Validated<NonEmptyListOf<FormError>, Form>).leftMap { (e) -> NonEmptyList<FormError> in
            e.fix()
        }
    }

    private static func validateFirstName(_ firstName: String) -> FormValidationResult<String> {
        if !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return Validated.valid(firstName)
        } else {
            return Validated.invalid(NonEmptyList(head: FormError.emptyFirstName(firstName), tail: []))
        }
    }

    private static func validateLastName(_ lastName: String) -> FormValidationResult<String> {
        if !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return Validated.valid(lastName)
        } else {
            return Validated.invalid(NonEmptyList(head: FormError.emptyLastName(lastName), tail: []))
        }
    }

    private static func validateBirthday(_ referenceDate: Date,
                                         _ birthday: Date) -> FormValidationResult<Date> {
        if Calendar.current.date(byAdding: .year, value: 18, to: birthday)! < referenceDate {
            return Validated.valid(birthday)
        } else {
            return Validated.invalid(NonEmptyList(head: FormError.userTooYoung(birthday), tail: []))
        }
    }

    private static func validateDocumentId(_ documentId: String) -> FormValidationResult<String> {
        if documentRegEx.firstMatch(in: documentId, options: [],
                                     range: NSRange(location: 0,
                                                    length: documentId.utf16.count)) != nil {
            return Validated.valid(documentId)
        } else {
            return Validated.invalid(NonEmptyList(head: FormError.invalidDocumentId(documentId), tail: []))
        }
    }

    private static func validatePhoneNumber(_ phoneNumber: String) -> FormValidationResult<String> {
        if phoneRegEx.firstMatch(in: phoneNumber, options: [],
                                  range: NSRange(location: 0,
                                                 length: phoneNumber.utf16.count)) != nil {
            return Validated.valid(phoneNumber)
        } else{
            return Validated.invalid(NonEmptyList(head: FormError.invalidPhoneNumber(phoneNumber), tail: []))
        }
    }

    private static func validateEmail(_ email: String) -> FormValidationResult<String> {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).contains("@") {
            return Validated.valid(email)
        } else {
            return Validated.invalid(NonEmptyList(head: FormError.invalidEmail(email), tail: []))
        }
    }

    private static let documentRegEx = try! NSRegularExpression(pattern: "\\d{8}[a-zA-Z]{1}")
    private static let phoneRegEx = try! NSRegularExpression(pattern: "\\d{9}")

}
