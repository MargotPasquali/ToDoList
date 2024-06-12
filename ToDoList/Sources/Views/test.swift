//import SwiftUI
//
//struct test: View {
//    @ObservedObject var viewModel: ToDoListViewModel  // Assurez-vous que le ViewModel est initialisé correctement ailleurs.
//    @State private var newTodoTitle = ""
//    @State private var isShowingAlert = false
//    @State private var isAddingTodo = false
//    let filters = ["Tous", "Terminés", "Actifs"]  // Correspond aux indices 0, 1, et 2 du ViewModel
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.filteredItems) { item in
//                HStack {
//                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
//                        .foregroundColor(item.isDone ? .green : .gray)
//                    Text(item.title)
//                }
//            }
//            .navigationTitle("To-Do List")
//            .toolbar {
//                
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Picker("Filter", selection: $viewModel.selectedFilter) {
//                        Text("All").tag(0)
//                        Text("Done").tag(1)
//                        Text("Not Done").tag(2)
//                    }
//                    .pickerStyle(.segmented)
//                    .onChange(of: viewModel.selectedFilter, perform: { _ in
//                        viewModel.applyFilter()
//                    })
//                }
//            }
//        }
//    }
//}
//
//// Assurez-vous d'avoir un PreviewProvider correctement configuré.
//struct test_Previews: PreviewProvider {
//    static var previews: some View {
//        test(viewModel: ToDoListViewModel(repository: ToDoListRepository()))
//    }
//}
