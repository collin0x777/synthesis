//
//  BrowseView.swift
//  Synthesis Notepad
//
//  Created by Collin Gray on 1/23/23.
//

import SwiftUI

struct BrowseView: View {
    @Binding var noteList: [Note]
    @State var editNoteSheet = false
    @State var noteText = ""
    @State var noteId: UUID? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(noteList.reversed()) { note in
                    Button {
                        editNoteSheet = true
                        noteText = note.text
                        noteId = note.id
                    } label: {
                        HStack {
                            Text(note.summary)
                            Spacer()
                            Text(note.creationDate.formatted(date: .abbreviated, time: .omitted))
                                .foregroundColor(.secondary)
                        }
                    }.sheet(isPresented: $editNoteSheet) {
                        NavigationView {
                            TextField("Edit note", text: $noteText)
                                .multilineTextAlignment(.center)
                                .navigationTitle("Edit note")
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Cancel") {
                                            editNoteSheet = false
                                            noteText = ""
                                        }
                                    }
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Done") {
                                            editNoteSheet = false
                                            let noteIndex = noteList.firstIndex { note in
                                                note.id == noteId!
                                            }
                                            if let idx = noteIndex {
                                                noteList[idx].updateText(noteText)
                                            }
                                            
                                            noteText = ""
                                        }
                                    }
                                }
                        }.interactiveDismissDisabled(true)
                    }
                }.onDelete { IndexSet in
                    IndexSet.forEach { idx in
                        noteList.remove(at: noteList.count - 1 - idx)
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationBarTitle(Text("Browse"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink {
                    Text("Info").navigationTitle(Text("Info"))
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}
