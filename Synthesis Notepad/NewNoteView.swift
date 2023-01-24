//
//  NewNoteView.swift
//  Synthesis Notepad
//
//  Created by Collin Gray on 1/23/23.
//

import SwiftUI

struct NewNoteView: View {
    @Binding var noteList: [Note]
    @State var newNoteSheet = false
    @State var noteText = ""
    
    var body: some View {
        Button {
            newNoteSheet = true
        } label: {
            Image(systemName: "note.text.badge.plus")
                .imageScale(.large)
                .foregroundColor(Color(UIColor.systemBackground))
                .padding(.all)
                .background(Color.accentColor, in: Circle())
        }.sheet(isPresented: $newNoteSheet) {
            NavigationView {
                TextField("New note", text: $noteText)
                    .multilineTextAlignment(.center)
                    .navigationTitle("New note")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                newNoteSheet = false
                                noteText = ""
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                newNoteSheet = false
                                noteList.append(Note(noteText))
                                noteText = ""
                            }
                        }
                    }
            }
        }
        .padding(.trailing, 30)
        .padding(.bottom, 70)
            
    }
}
