//
//  Extensions.swift
//  MIAapp
//
//  Created by Sören Kirchner on 30.01.22.
//

import Foundation
import UIKit
import SwiftUI

extension URL: Identifiable {
    public var id: Self { self }
}

extension String {

    public func fromHtmlToAttributed() -> AttributedString {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let attributedString = try? NSMutableAttributedString(data: trimmed.data(using: .unicode)!,
                                                             options: [.documentType: NSAttributedString.DocumentType.html],
                                                             documentAttributes: nil)
        else { print("ERROR"); return AttributedString("ERROR") }
        let font = UIFont.preferredFont(forTextStyle: .body)
        let textRangeForFont : NSRange = NSMakeRange(0, attributedString.length)
        attributedString.addAttributes([NSAttributedString.Key.font: font], range: textRangeForFont)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.label], range: textRangeForFont)
        return AttributedString(attributedString)
    }

}

public extension Color {
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
}
