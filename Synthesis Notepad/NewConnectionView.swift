//
//  NewConnectionView.swift
//  Synthesis Notepad
//
//  Created by Collin Gray on 1/23/23.
//

import SwiftUI

struct NewConnectionView: View {
    @Binding var newConnectionSheet: Bool
    @Binding var notes: [Note]
    @Binding var note1: UUID?
    @Binding var note2: UUID?
    
    @State var connectionText = ""
    
    var body: some View {
        NavigationView {
            List {
                Picker("First note", selection: $note1) {
                    if note1 == nil {
                        Text("Choose a note")
                    }
                    
                    ForEach(notes) { note in
                        if note.id != note2 {
                            Text(note.text).tag(Optional.some(note.id))
                        }
                    }
                }
                Picker("Second note", selection: $note2) {
                    if note2 == nil {
                        Text("Choose a note")
                    }
                    
                    ForEach(notes) { note in
                        if note.id != note1 {
                            Text(note.text).tag(Optional.some(note.id))
                        }
                    }
                }
                Section {
                    TextField("Enter note", text: $connectionText)
                        .multilineTextAlignment(.center)
                    
                }
            }
//                .multilineTextAlignment(.center)
                .navigationTitle("New connection")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            newConnectionSheet = false
//                            noteText = ""
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            newConnectionSheet = false
//                            noteList.append(Note(noteText))
//                            noteText = ""
                        }
                    }
                }
        }.interactiveDismissDisabled(true)
    }
}
