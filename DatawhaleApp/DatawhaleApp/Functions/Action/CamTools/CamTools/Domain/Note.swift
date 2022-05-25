//
//  NoteModel.swift
//  CamTools
//
//  Created by Hab Yang on 2022/2/25.
//

import Foundation
import UIKit

/// Extension of the generated `Note` Core Data model with added convenience.
extension Note {
  var wrappedTitle: String {
    get { title ?? "" }
    set { title = newValue }
  }

  var wrappedBody: String {
    get { body ?? "" }
    set { body = newValue }
  }

  var identifier: String {
    objectID.uriRepresentation().absoluteString
  }

  public override func willChangeValue(forKey key: String) {
    super.willChangeValue(forKey: key)

    // Helper to keep lastModified up-to-date when other properties are modified
    if key == "title" || key == "body" || key == "isFavorite" {
      lastModified = Date()
    }
  }

  // 1
  var shortcutItem: UIApplicationShortcutItem? {
    // 2
    guard !wrappedTitle.isEmpty || !wrappedBody.isEmpty else { return nil }

    // 3
    return UIApplicationShortcutItem(
      type: ActionType.editNote.rawValue,
      localizedTitle: "Edit Note",
      localizedSubtitle: wrappedTitle.isEmpty ? wrappedBody : wrappedTitle,
      icon: .init(systemImageName: isFavorite ? "star" : "pencil"),
      userInfo: [
        "NoteID": identifier as NSString
      ]
    )
  }
}
