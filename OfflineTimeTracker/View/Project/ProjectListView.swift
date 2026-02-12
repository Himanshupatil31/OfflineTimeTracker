//
//  ProjectListView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//


import SwiftUI


struct ProjectListView: View {
    @StateObject private var viewModel: ProjectListViewModel

    // UI State
    @State private var showProjectAlert = false
    @State private var projectName = ""
    @State private var projectToRename: Project?

    @State private var projectToDelete: Project?
    @State private var showDeleteAlert = false

    init(viewModel: ProjectListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.filteredProjects.isEmpty {
                    ContentUnavailableView(
                        "No Data",
                        systemImage: "folder",
                        description: Text("Start adding projects here")
                    )
                } else {
                    List {
                        ForEach(viewModel.filteredProjects) { project in
                            ProjectRowView(project: project)
                                .contextMenu {
                                    Button("Rename") {
                                        projectToRename = project
                                        projectName = project.name
                                        showProjectAlert = true
                                    }

                                    Button(role: .destructive) {
                                        projectToDelete = project
                                        showDeleteAlert = true
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Projects")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        projectName = ""
                        projectToRename = nil
                        showProjectAlert = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert(
                projectToRename == nil ? "New Project" : "Rename Project",
                isPresented: $showProjectAlert
            ) {
                TextField("Project name", text: $projectName)

                Button("Save") {
                    let trimmed = projectName.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmed.isEmpty else { return }

                    if let project = projectToRename {
                        viewModel.renameProject(project, newName: trimmed)
                    } else {
                        viewModel.addProject(name: trimmed)
                    }
                }

                Button("Cancel", role: .cancel) {}
            }
            .alert(
                "Delete Project",
                isPresented: $showDeleteAlert,
                presenting: projectToDelete
            ) { project in
                Button("Delete", role: .destructive) {
                    viewModel.deleteProject(project)
                    projectToDelete = nil
                }
                Button("Cancel", role: .cancel) {
                    projectToDelete = nil
                }
            } message: { project in
                Text("Are you sure you want to delete \"\(project.name)\"?")
            }
        }
    }
}
