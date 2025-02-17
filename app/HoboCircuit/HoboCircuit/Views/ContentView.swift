//
//  ContentView.swift
//  HoboCircuit
//
//  Created by Matti Stenvall on 17.2.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var title: String = ""
    @State private var routine: String = ""
    @State private var usernote: String = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Entry.title, ascending: true)]
    ) private var entries: FetchedResults<Entry>
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Workout Entry")
                .font(.title)
                .padding()
            
            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Routine", text: $routine)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("User Note", text: $usernote)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Save Entry") {
                saveEntry()
            }
            .buttonStyle(.borderedProminent)
              
            Button("Clear All Entries") {
                clearEntries()
            }
            .buttonStyle(.bordered)
            
            List(entries, id: \.objectID) { entry in
                VStack(alignment: .leading) {
                    Text("Title: \(entry.title ?? "No Title")")
                        .font(.headline)
                    Text("Routine: \(entry.routine ?? "No Routine")")
                    Text("Note: \(entry.userNote ?? "No Note")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
    }
    
    private func saveEntry() {
        NSLog("saveEntry clicked")
        
        let newEntry = Entry(context: viewContext)
        newEntry.title = title
        newEntry.routine = routine
        newEntry.usernote = usernote
        
        do {
            try viewContext.save()
            title = ""
            routine = ""
            usernote = ""
        } catch {
            print("Save error: \(error.localizedDescription)")
        }
    }
    
    private func clearEntries() {
        NSLog("clearEntries clicked")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Entry.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch {
            print("Clear error: \(error.localizedDescription)")
        }    }
}

#Preview {
    ContentView()
}
