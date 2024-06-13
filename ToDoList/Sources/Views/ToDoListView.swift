import SwiftUI

struct ToDoListView: View {
    @ObservedObject var viewModel = ToDoListViewModel()

    @State private var newTodoTitle = ""
    @State private var isShowingAlert = false
    @State private var isAddingTodo = false

    let filters = ["All", "Done", "Not Done"]  // Correspond aux indices 0, 1, et 2 du ViewModel

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    // Filter selector with a Picker
                    Picker("Filter", selection: $viewModel.currentFilterIndex) {
                        ForEach(Array(filters.enumerated()), id: \.element) { index, filter in
                            Text(filter).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                .padding(.horizontal)
                .padding(.vertical)

                // List of tasks
                List {
                    ForEach(viewModel.filteredItems) { item in
                        HStack {
                            Button(action: {
                                viewModel.toggleTodoItemCompletion(item)
                            }) {
                                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(item.isDone ? .green : .primary)
                            }
                            Text(item.title)
                                .font(item.isDone ? .subheadline : .body)
                                .strikethrough(item.isDone)
                                .foregroundColor(item.isDone ? .gray : .primary)
                        }
                    }
                    .onDelete { indices in
                        indices.forEach { index in
                            viewModel.removeTodoItem(index)
                        }
                    }
                }

                // Sticky bottom view for adding todos
                if isAddingTodo {
                    HStack {
                        TextField("Enter Task Title", text: $newTodoTitle)
                            .padding(.leading)

                        Spacer()

                        Button(action: {
                            if newTodoTitle.isEmpty {
                                isShowingAlert = true
                            } else {
                                viewModel.addItem(with: newTodoTitle)
                                
                                newTodoTitle = "" // Reset newTodoTitle to empty.
                                isAddingTodo = false // Close the bottom view after adding
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                }

                // Button to toggle the bottom add view
                Button(action: {
                    isAddingTodo.toggle()
                }) {
                    Text(isAddingTodo ? "Close" : "Add Task")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()

            }
            .navigationBarTitle("To-Do List")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

#Preview("Default") {
    ToDoListView()
}

#Preview("Default with variation") {
    ToDoListView()
}
