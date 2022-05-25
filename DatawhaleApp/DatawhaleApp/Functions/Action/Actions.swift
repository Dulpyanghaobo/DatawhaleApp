//
//  Actions.swift
//  DatawhaleApp
//
//  Created by Hab Yang on 2022/2/25.
//

import Foundation

// 1
enum ActionType: String {
  case newNote = "NewNote"
  case editNote = "EditNote"
}

// 2
enum Action: Equatable {
  case newNote
  case editNote(identifier: String)

  // 3
  init?(shortcutItem: UIApplicationShortcutItem) {
    // 4
    guard let type = ActionType(rawValue: shortcutItem.type) else {
      return nil
    }

    // 5
    switch type {
    case .newNote:
      self = .newNote
    case .editNote:
      if let identifier = shortcutItem.userInfo?["NoteID"] as? String {
        self = .editNote(identifier: identifier)
      } else {
        return nil
      }
    }
  }
}

// 6
class ActionService: ObservableObject {
  static let shared = ActionService()

  // 7
  @Published var action: Action?
}
