//
//  Strings.swift
//  SpeakSelectionDemoTests
//
//  Created by Adam Niepokój on 12/06/2021.
//

import Foundation

/// Strings present in the app.
enum Strings {

    enum BankAccountScreen {
        static let navbarTitle = "Your bank account"
        static let title = "Top up your account using regular bank transfer"
        static let description = """
        Topping-up your XYZ account with traditional bank transfer is very easy! You just have to log in to your bank account and send appropriate amount of money to the bank account visible below.

        Your bank account:
        """
        static let buttonTitle = "Show inaccessible screen"
    }

    enum AccessibleBankAccountScreen {
        static let description = """
        Bacon ipsum dolor amet jerky turducken tail biltong, swine porchetta fatback jowl. Ground round alcatra buffalo pork chop porchetta, bresaola doner pig cow. Fatback pig ham t-bone. Chuck leberkas jerky venison sirloin porchetta drumstick meatloaf pig.

        Your bank account:
        """
        static let buttonTitle = "Show accessible screen"
    }

    enum General {
        static let copy = "Copy"
        static let speak = "Speak"
    }
}
