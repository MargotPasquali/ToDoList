import Foundation

struct ToDoItem {

    let id: UUID
    let title: String
    private (set) var isDone: Bool

    init(id: UUID = .init(), title: String, isDone: Bool = false) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }

    mutating func toggleDone() {
        isDone.toggle()
    }
}

// MARK: - Identifiable

extension ToDoItem: Identifiable {

}

// MARK: - Equatable

extension ToDoItem: Equatable {

}

// MARK: - Codable

extension ToDoItem: Codable {

}
