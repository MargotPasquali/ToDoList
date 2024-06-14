//import SwiftUI
//
//final class ToDoListViewModel: ObservableObject {
//    // MARK: - Private properties
//
//    private let repository: ToDoListRepositoryType
//
//    @Published var currentFilterIndex: Int = 0 // Pour suivre le filtre actuel
//
//    // MARK: - Init
//
//    init(repository: ToDoListRepositoryType) {
//        self.repository = repository
//        self.toDoItems = repository.loadToDoItems()
//        applyFilter(at: currentFilterIndex) // Appliquer le filtre initial
//
//    }
//    
//    
//
//    // MARK: - Outputs
//
//    /// Publisher for the list of to-do items.
//    @Published var toDoItems: [ToDoItem] = [] {
//        didSet {
//            repository.saveToDoItems(toDoItems)
//        }
//    }
//
//    // MARK: - Inputs
//
//    // Add a new to-do item with priority and category
//    func add(item: ToDoItem) {
//        toDoItems.append(item)
//    }
//
//    /// Toggles the completion status of a to-do item.
//    func toggleTodoItemCompletion(_ item: ToDoItem) {
//        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
//            toDoItems[index].isDone.toggle()
//        }
//    }
//
//    /// Removes a to-do item from the list.
//    func removeTodoItem(_ item: ToDoItem) {
//        toDoItems.removeAll { $0.id == item.id }
//    }

    /// Apply the filter to update the list.
//    func applyFilter(at index: Int) {
//           currentFilterIndex = index // Mettre à jour l'index du filtre actuel
//
//            switch index {
//            case 0:
//                toDoItems = repository.loadToDoItems() // Tous les éléments
//            case 1:
//                toDoItems = repository.loadToDoItems().filter { $0.isDone } // Éléments terminés
//            case 2:
//                toDoItems = repository.loadToDoItems().filter { !$0.isDone } // Éléments non terminés
//            default:
//                toDoItems = repository.loadToDoItems() // Fallback à tous les éléments
//            }
//        }
    

//}


    import SwiftUI

    final class ToDoListViewModel: ObservableObject {
        // MARK: - Private properties
        private let repository: ToDoListRepositoryType

        @Published var allItems: [ToDoItem] = [] // Stocker toutes les tâches chargées
        @Published var toDoItems: [ToDoItem] = [] // Pour les tâches filtrées
        @Published var currentFilterIndex: Int = 0 // Pour suivre le filtre actuel

        // MARK: - Init
        init(repository: ToDoListRepositoryType) {
            self.repository = repository
            loadItems() // Charger et appliquer le filtre initial
        }

        private func loadItems() {
            allItems = repository.loadToDoItems() // Charger les tâches depuis le dépôt
            applyFilter(at: currentFilterIndex) // Appliquer le filtre initial
        }

        // MARK: - Filtration Logic
        
        /// Apply the filter to update the list.
        func applyFilter(at index: Int) {
            currentFilterIndex = index // Mettre à jour l'index du filtre actuel

            switch index {
            case 0:
                toDoItems = allItems // Afficher tous les éléments
            case 1:
                toDoItems = allItems.filter { $0.isDone } // Afficher seulement les éléments terminés
            case 2:
                toDoItems = allItems.filter { !$0.isDone } // Afficher seulement les éléments non terminés
            default:
                toDoItems = allItems // Fallback à tous les éléments si aucun cas n'est matché
            }
        }

        // MARK: - Task Management
        
        /// Add a new to-do item with priority and category
        func add(item: ToDoItem) {
            allItems.append(item)
            applyFilter(at: currentFilterIndex)
        }

        /// Toggles the completion status of a to-do item
        func toggleTodoItemCompletion(_ item: ToDoItem) {
            if let index = allItems.firstIndex(where: { $0.id == item.id }) {
                allItems[index].isDone.toggle()
                applyFilter(at: currentFilterIndex)
            }
        }

        /// Removes a to-do item from the list.
        func removeTodoItem(_ item: ToDoItem) {
            allItems.removeAll { $0.id == item.id }
            applyFilter(at: currentFilterIndex)
        }
    }
