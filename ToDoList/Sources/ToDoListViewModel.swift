import SwiftUI

final class ToDoListViewModel: ObservableObject {

    // MARK: - Constants

    private let repository: ToDoListRepository

    // MARK: - Properties

    @Published var currentFilterIndex = 0 {
        didSet {
            applyFilter()
        }
    }

    private (set) var toDoItems: [ToDoItem] = []

    @Published
    var filteredItems: [ToDoItem] = []

    // MARK: - Init

    init(repository: ToDoListRepository = LocalFileToDoListRepository()) {
        self.repository = repository

        toDoItems = repository.loadToDoItems()

        filteredItems = toDoItems
    }

    // MARK: - Functions

    // Add a new to-do item with priority and category
    func addItem(with title: String, isDone: Bool = false) {
        guard !title.isEmpty else { return }

        toDoItems.append(ToDoItem(title: title, isDone: isDone))

        repository.saveToDoItems(toDoItems)
    }

    /// Toggles the completion status of a to-do item.
    func toggleTodoItemCompletion(_ item: ToDoItem) {
        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
            toDoItems[index].toggleDone()
        }

        applyFilter()

        repository.saveToDoItems(toDoItems)
    }

    /// Removes a to-do item from the list.
    func removeTodoItem(_ index: Int) {
        let itemToDelete = toDoItems[index]

        toDoItems.removeAll { $0.id == itemToDelete.id }

        repository.saveToDoItems(toDoItems)
    }

    func applyFilter() {
        filteredItems = filter(at: currentFilterIndex, to: toDoItems)
    }

    /// Apply the filter to update the list.
    private func filter(at index: Int, to items: [ToDoItem]) -> [ToDoItem] {
        return switch index {
        case 1:
            items.filter { $0.isDone }
        case 2:
            items.filter { !$0.isDone }

        default:
            items
        }
    }
}
