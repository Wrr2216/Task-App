//
//  ContentView.swift
//  Task App
//
//  Created by Logan Miller on 1/2/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // Define the CoreDataManager class
    let coreDM: CoreDataManager
    
    // Define the Item title and description
    @State private var itemTitle: String = ""
    @State private var itemDesc: String = ""
    
    // Define the items array from the ListItem entity
    @State private var items: [ListItem] = [ListItem]()
    
    // This is used for the alert when creating tasks
    @State private var presentAlert = false
    
    // Declare if the task is high priority, currently not used TODO
    @State private var highPriority: Bool = true
    
    // Defines the state for refreshing the contents when adding an item
    @State private var needsRefresh: Bool = false
    
    // refresh the items array with updated information
    private func populateItems(){
        items = coreDM.getAllItems()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                
                // Button to create new task
                // This pops up an alert box that lets the user add the title and description
                
                // This is the code for populating the list of items
                List {
                    ForEach(items, id: \.self){ item in
                        VStack(alignment: .leading) {
                            Text(item.title ?? "")
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                            Text(item.desc ?? "")
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                        }
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("AccentColor")/*@END_MENU_TOKEN@*/)
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach{ index in
                            let item = items[index]
                            coreDM.deleteItem(listItem: item)
                            populateItems()
                        }
                    })
                    Button("Create New Task"){
                        presentAlert = true
                    }.alert("Create new task", isPresented: $presentAlert, actions: {
                        TextField("Task Name", text: $itemTitle)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        TextField("Task Description", text: $itemDesc)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        
                        Button("Finish", action: {
                            if !itemTitle.isEmpty {
                                coreDM.saveItem(title: itemTitle, desc: itemDesc)
                                itemTitle = ""
                                itemDesc = ""
                                populateItems()
                            }else{
                                
                            }
                            
                        })
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Name your task and give it a short description.")
                    })
                }
                .foregroundColor(.black)
                .background(.white)
                
                Spacer()
            }.padding()
                .navigationBarTitle("Tasks", displayMode: .inline)
            
                // This makes sure the items populate the list when the app loads
                .onAppear(perform: {
                    items = coreDM.getAllItems()
                })
            
            VStack {
          
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
            
        }
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(coreDM: CoreDataManager())
        }
    }
    
