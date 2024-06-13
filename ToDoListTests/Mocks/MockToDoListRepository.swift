@testable import ToDoList
import Foundation

final class MockToDoListRepository: ToDoListRepository {
    var mockToDoItems: [ToDoItem]

    init(initialItems: [ToDoItem] = []) {
        self.mockToDoItems = initialItems
    }

    func loadToDoItems() -> [ToDoItem] {
        mockToDoItems
    }

    func saveToDoItems(_ items: [ToDoItem]) {
        mockToDoItems = items
    }
}
