import Foundation

/// Modèle représentant un élément de la liste des tâches.
struct ToDoItem {
    // MARK: - Properties

    /// Identifiant unique de l'élément.
    var id: UUID = UUID()

    /// Titre de la tâche
    var title: String

    /// Indique si l'élément est marqué comme terminé.
    var isDone: Bool = false
}

// MARK: - Equatable
extension ToDoItem: Equatable {}

// MARK: - Codable
extension ToDoItem: Codable {}

// MARK: - Identifiable
extension ToDoItem: Identifiable {}
