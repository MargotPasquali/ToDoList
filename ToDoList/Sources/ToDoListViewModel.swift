    import SwiftUI

    final class ToDoListViewModel: ObservableObject {
        // MARK: - Private properties
        private let repository: ToDoListRepositoryType

        @Published var allItems: [ToDoItem] = [] // Stocker toutes les tâches chargées
        @Published var toDoItems: [ToDoItem] = [] // Pour les tâches filtrées
        @Published var currentFilter: Filter = .all // Pour suivre le filtre actuel

        
        // Définition de l'énumération Filter avec conformité à CaseIterable et Identifiable
        enum Filter: String, CaseIterable, Identifiable {
            case all = "All"
            case done = "Done"
            case pending = "Not Done"
            
            var id: Filter { self }
        }
        
        // MARK: - Init
    
        init(repository: ToDoListRepositoryType) {
            self.repository = repository
            loadItems() // Charger et appliquer le filtre initial
        }

        private func loadItems() {
            allItems = repository.loadToDoItems() // Charger les tâches depuis le dépôt
            applyFilter(to: currentFilter) // Appliquer le filtre initial
        }

        // MARK: - Filtration Logic
        
        /// Apply the filter to update the list.
        func applyFilter(to filter: Filter) {
                currentFilter = filter
                switch filter {
                case .done:
                    toDoItems = allItems.filter { $0.isDone }
                case .pending:
                    toDoItems = allItems.filter { !$0.isDone }
                case .all:
                    toDoItems = allItems
                }
            }

        // MARK: - Task Management
        
        /// Add a new to-do item with priority and category
        func add(item: ToDoItem) {
            allItems.append(item)
            applyFilter(to: currentFilter)
        }

        /// Toggles the completion status of a to-do item
        func toggleTodoItemCompletion(_ item: ToDoItem) {
            if let index = allItems.firstIndex(where: { $0.id == item.id }) {
                allItems[index].isDone.toggle()
                applyFilter(to: currentFilter)
            }
        }

        /// Removes a to-do item from the list.
        func removeTodoItem(_ item: ToDoItem) {
            allItems.removeAll { $0.id == item.id }
            applyFilter(to: currentFilter)
        }
    }
