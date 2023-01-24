//
//  GraphView.swift
//  Synthesis Notepad
//
//  Created by Collin Gray on 1/23/23.
//

import SwiftUI

struct GraphView: View {
    var body: some View {
        NavigationStack {
            Text("Graph")
            Spacer()
        }
        .navigationBarTitle(Text("Graph"))
        .toolbar {
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
