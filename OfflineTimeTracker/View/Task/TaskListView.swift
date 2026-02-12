//
//  TaskListView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//


import SwiftUI

struct TaskListView: View {

    @StateObject var viewModel: TaskListViewModel
    @State private var showAddTask = false
    @State private var newTaskTitle = ""
    @State private var showDeleteAllAlert = false

    // MARK: - Body
    var body: some View {
        content
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Tasks")
            .toolbar { toolbarContent }

            .sheet(isPresented: $showAddTask) {
                addTaskSheet
            }
            .onAppear {
                viewModel.load()
            }
    }

    // MARK: - Main Content
    @ViewBuilder
    private var content: some View {
        VStack {
            if viewModel.filteredTasks.isEmpty {
                emptyView
            } else {
                taskList
            }
        }
    }

    // MARK: - Empty View
    private var emptyView: some View {
        ContentUnavailableView(
            "No Data",
            systemImage: "folder",
            description: Text("Start adding tasks here")
        )
    }

    // MARK: - Task List
    private var taskList: some View {
        List {
            ForEach(viewModel.filteredTasks) { task in
                taskRow(task)
            }
        }
    }

    // MARK: - Task Row
    private func taskRow(_ task: TaskItem) -> some View {
        TaskRowView(task: task)
     
    }

    // MARK: - Destination View
    private func taskDetailView(for task: TaskItem) -> some View {
        TaskDetailView(
            viewModel: TimerViewModel(
                taskId: task.id, taskObjectID: task.objectID,
                sessionRepository: AppContainer.shared.sessionRepo,
                tagRepository: AppContainer.shared.tagRepo
            )
        )
    }

    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {

        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                showAddTask = true
            } label: {
                Image(systemName: "plus")
            }
        }
    }

    // MARK: - Add Task Sheet
    private var addTaskSheet: some View {
        NavigationStack {
            Form {
                TextField("Task title", text: $newTaskTitle)
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        resetAddTaskState()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        viewModel.addTask(title: newTaskTitle)
                        resetAddTaskState()
                    }
                    .disabled(newTaskTitle.isEmpty)
                }
            }
        }
    }

    private func resetAddTaskState() {
        showAddTask = false
        newTaskTitle = ""
    }
}
