//
//  ConnectionsView.swift
//  Synthesis Notepad
//
//  Created by Collin Gray on 1/23/23.
//

import SwiftUI

struct ConnectionsView: View {
    @Binding var notes: [Note]
    @Binding var suggestedConnections: [Connection]
    @Binding var formedConnections: [Connection]
    
    @State var newConnectionSheet = false
    @State var note1Id: UUID?
    @State var note2Id: UUID?
    
    @ViewBuilder
    func drawSuggestedConnections(notes: [Note], connections: [Connection]) -> some View {
        Section("Suggested connections") {
            ForEach(suggestedConnections) { connection in
                if let note1 = notes.first(where: { note in note.id == connection.firstId }),
                   let note2 = notes.first(where: { note in note.id == connection.secondId }) {
                    
                    Button {
                        newConnectionSheet = true
                        note1Id = note1.id
                        note2Id = note2.id
                    } label: {
                        HStack {
                            Text(note1.summary)
                                .padding(.trailing, -30.0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundColor(.primary)
                            Image(systemName: "bolt.horizontal")
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text(note2.summary)
                                .padding(.leading, -30.0)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func drawFormedConnections(notes: [Note], connections: [Connection]) -> some View {
        ForEach(connections) { connection in
            if let note1 = notes.first(where: { note in note.id == connection.firstId }),
               let note2 = notes.first(where: { note in note.id == connection.secondId }) {
                HStack {
                    Text(note1.summary)
                    Text(note2.summary)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    if !suggestedConnections.isEmpty {
                        drawSuggestedConnections(notes: notes, connections: suggestedConnections)
                    }
                    
                    drawFormedConnections(notes: notes, connections: formedConnections)
                }
            }
            .navigationBarTitle(Text("Connections"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        newConnectionSheet = true
                        note1Id = nil
                        note2Id = nil
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        Text("Info").navigationTitle(Text("Info"))
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }.sheet(isPresented: $newConnectionSheet) {
                NewConnectionView(
                    newConnectionSheet: $newConnectionSheet,
                    notes: $notes,
                    note1: $note1Id,
                    note2: $note2Id
                )
            }
            
            if formedConnections.isEmpty && suggestedConnections.isEmpty {
                VStack {
                    Spacer()
                    Text("No connections have been formed")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Text("Start writing notes and they will be suggested automatically once found")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
        }
    }
}
