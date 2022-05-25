//
//  Actions.swift
//  CamTools
//
//  Created by Hab Yang on 2022/2/25.
//

import UIKit

// 1
enum ActionType: String {
    case editNote = "editNote"
    case newNote = "NewNote"
}

// 2
enum Action: Equatable {
    case newNote
    case editNote

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
        self = .editNote
    }
  }
}

// 6
class ActionService: ObservableObject {
  static let shared = ActionService()

  // 7
  @Published var action: Action?
}
