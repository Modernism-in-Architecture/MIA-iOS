//
//  String+fromHtmlToAttributed.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 16.07.23.
//

import UIKit

extension String {

    func fromHtmlToAttributed() -> AttributedString {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let attributedString = try? NSMutableAttributedString(data: trimmed.data(using: .unicode)!,
                                                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                                                    documentAttributes: nil)
        else {
            return AttributedString("ERROR")
        }

        let font = UIFont.preferredFont(forTextStyle: .body)
        let textRangeForFont: NSRange = NSMakeRange(0, attributedString.length)
        attributedString.addAttributes([NSAttributedString.Key.font: font], range: textRangeForFont)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.label], range: textRangeForFont)
        return AttributedString(attributedString)
    }
}
