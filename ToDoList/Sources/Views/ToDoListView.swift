import SwiftUI

struct ToDoListView: View {
    @ObservedObject var viewModel: ToDoListViewModel
    @State private var newTodoTitle = ""
    @State private var isShowingAlert = false
    @State private var isAddingTodo = false

    
// Utiliser l'enum Filter directement
    @State private var selectedFilter: ToDoListViewModel.Filter = .all
    
    var body: some View {
        NavigationView {
            VStack {
                    getFilter()
                    
                    // List of tasks
                    getListofToDoItems()
                    
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
                                    viewModel.add(
                                        item: .init(
                                            title: newTodoTitle
                                        )
                                    )
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
    func getFilter() -> some View {
        VStack {
            // Filter selector with a Picker
            Picker("Filter", selection: $selectedFilter) {
                ForEach(ToDoListViewModel.Filter.allCases) { filter in
                    Text(filter.rawValue).tag(filter)
                               }
                           }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: selectedFilter) { newValue in
                               // Appel à applyFilter du ViewModel avec l'index correct
                               viewModel.applyFilter(to: newValue)
                }
            }.padding()
    }
    
    func getListofToDoItems() -> some View {
        List {
            ForEach(viewModel.toDoItems) { item in
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
                    let item = viewModel.toDoItems[index]
                    viewModel.removeTodoItem(item)
                }
            }
        }
    }
    }

#Preview {
    ToDoListView(viewModel: ToDoListViewModel(repository: ToDoListRepository()))
}
