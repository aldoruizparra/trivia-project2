//
//  String+HTMLDecoded.swift
//  Trivia
//
//  Created by Aldo Ruiz Parra on 7/5/25.
//

import Foundation

extension String {
  var htmlDecoded: String {
    guard let data = data(using: .utf8) else { return self }
    let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
      .documentType: NSAttributedString.DocumentType.html,
      .characterEncoding: String.Encoding.utf8.rawValue
    ]
    let decoded = try? NSAttributedString(data: data, options: options, documentAttributes: nil).string
    return decoded ?? self
  }
}
