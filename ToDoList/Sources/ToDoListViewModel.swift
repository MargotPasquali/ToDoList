import SwiftUI

final class ToDoListViewModel: ObservableObject {
    // MARK: - Private properties

    private let repository: ToDoListRepositoryType

    @Published var currentFilterIndex: Int = 0 // Pour suivre le filtre actuel

    // MARK: - Init

    init(repository: ToDoListRepositoryType) {
        self.repository = repository
        self.toDoItems = repository.loadToDoItems()
        applyFilter(at: currentFilterIndex) // Appliquer le filtre initial

    }

    // MARK: - Outputs

    /// Publisher for the list of to-do items.
    @Published var toDoItems: [ToDoItem] = [] {
        didSet {
            repository.saveToDoItems(toDoItems)
        }
    }

    // MARK: - Inputs

    // Add a new to-do item with priority and category
    func add(item: ToDoItem) {
        toDoItems.append(item)
    }

    /// Toggles the completion status of a to-do item.
    func toggleTodoItemCompletion(_ item: ToDoItem) {
        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
            toDoItems[index].isDone.toggle()
        }
    }

    /// Removes a to-do item from the list.
    func removeTodoItem(_ item: ToDoItem) {
        toDoItems.removeAll { $0.id == item.id }
    }

    /// Apply the filter to update the list.
    func applyFilter(at index: Int) {
           currentFilterIndex = index // Mettre à jour l'index du filtre actuel

            switch index {
            case 0:
                toDoItems = repository.loadToDoItems() // Tous les éléments
            case 1:
                toDoItems = repository.loadToDoItems().filter { $0.isDone } // Éléments terminés
            case 2:
                toDoItems = repository.loadToDoItems().filter { !$0.isDone } // Éléments non terminés
            default:
                toDoItems = repository.loadToDoItems() // Fallback à tous les éléments
            }
        }
    

}
