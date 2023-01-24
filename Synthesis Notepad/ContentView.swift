//
//  ContentView.swift
//  Synthesis Notepad
//
//  Created by Collin Gray on 1/22/23.
//

import SwiftUI

struct Note: Identifiable, Hashable {
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    let creationDate: Date = Date()
    
    @State var text: String
    @State var summary: String
    
    @State var embeddings: [Float]? = nil
    
    init(_ newText: String) {
        _text = State(initialValue: newText)
        _summary = State(initialValue: newText)
    }
    
    func updateText(_ text: String) {
        self.text = text
        self.summary = text
        self.embeddings = nil
    }
}

struct Connection: Identifiable {
    let id = UUID()

    let firstId: UUID
    let secondId: UUID

    init(_ first: Note, _ second: Note) {
        self.firstId = first.id
        self.secondId = second.id
    }
}

struct ContentView: View {

    @State var currentTab = 1
    @State var notes: [Note] = [
        Note("Note 1"),
        Note("Note 2"),
        Note("Note 3"),
        Note("Note 4"),
        Note("Note 5"),
        Note("Note 6"),
        Note("Note 21"),
        Note("Note 22"),
        Note("Note 23"),
        Note("Note 24"),
        Note("Note 25"),
        Note("Note 26"),
        Note("Note 31"),
        Note("Note 32"),
        Note("Note 33"),
        Note("Note 34"),
        Note("Note 35"),
        Note("Note 36"),
    ]
    @State var suggestedConnections: [Connection] = []
    @State var formedConnections: [Connection] = []

    var body: some View {
        ZStack {
            TabView(selection: $currentTab) {
                NavigationStack {
                    GraphView()
                }
                .tabItem {
                    Label("Graph", systemImage: "point.3.connected.trianglepath.dotted")
                }
                .tag(0)
                
                NavigationStack {
                    ConnectionsView(
                        notes: $notes,
                        suggestedConnections: $suggestedConnections,
                        formedConnections: $formedConnections
                    )
                }
                .tabItem {
                    Label("Connections", systemImage: "app.connected.to.app.below.fill")
                }
                .tag(1)
                
                NavigationStack {
                    BrowseView(noteList: $notes)
                }
                .tabItem {
                    Label("Browse", systemImage: "list.bullet")
                }
                .tag(2)
            }.onAppear {
                //Temporary, for testing
                suggestedConnections = [
                    Connection(notes[2], notes[3]),
                    Connection(notes[5], notes[3]),
                    Connection(notes[6], notes[8]),
                    Connection(notes[1], notes[9]),
                ]
                
                formedConnections = [
                    Connection(notes[2], notes[3]),
                    Connection(notes[5], notes[3]),
                    Connection(notes[6], notes[8]),
                    Connection(notes[1], notes[9]),
                ]
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NewNoteView(noteList: $notes)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
