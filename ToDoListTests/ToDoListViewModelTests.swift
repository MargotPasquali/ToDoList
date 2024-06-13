import XCTest
import Combine

@testable import ToDoList

final class ToDoListViewModelTests: XCTestCase {
    // MARK: - Properties

    private var viewModel: ToDoListViewModel!
    private var repository: MockToDoListRepository!

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        repository = MockToDoListRepository()
        viewModel = ToDoListViewModel(repository: repository)
    }

    // MARK: - Tear Down

    override func tearDown() {
        viewModel = nil
        repository = nil

        super.tearDown()
    }

    // MARK: - Tests

    func testAddTodoItem() {
        // When
        viewModel.addItem(with: "Test Task")

        // Then
        XCTAssertEqual(viewModel.toDoItems.count, 1)
        XCTAssertTrue(viewModel.toDoItems[0].title == "Test Task")
    }

    func testToggleTodoItemCompletion() {
        // Given
        viewModel.addItem(with: "Test Task")

        // When
        viewModel.toggleTodoItemCompletion(viewModel.toDoItems.first!)

        // Then
        XCTAssertTrue(viewModel.toDoItems[0].isDone)
    }

    func testRemoveTodoItem() {
        // Given
        viewModel.addItem(with: "Test Task")

        // When
        viewModel.removeTodoItem(0)

        // Then
        XCTAssertTrue(viewModel.toDoItems.isEmpty)
    }

    func testShouldReturnAllItemsWhenNoFilterIsSet() {
        // Given
        viewModel.addItem(with: "Task 1", isDone: true)
        viewModel.addItem(with: "Task 2")

        // When
        viewModel.applyFilter()
        // Then
        XCTAssertEqual(viewModel.filteredItems.count, 2) // tous les éléments
    }

    func testShouldReturnOnlyDoneItemsWhenDoneFilterIsSet() {
        // Given
        viewModel.addItem(with: "Task 1", isDone: true)
        viewModel.addItem(with: "Task 2")

        // When
        viewModel.currentFilterIndex = 1
        viewModel.applyFilter()
        // Then
        XCTAssertEqual(viewModel.filteredItems.count, 1) // éléments terminés
    }

    func testShouldReturnOnlyIncompleteItemsWhenIncompleteFilterIsSet() {
        // Given
        viewModel.addItem(with: "Task 1", isDone: true)
        viewModel.addItem(with: "Task 2")

        // When
        viewModel.currentFilterIndex = 2
        viewModel.applyFilter()
        // Then
        XCTAssertEqual(viewModel.filteredItems.count, 1) // éléments non terminés
    }
}
