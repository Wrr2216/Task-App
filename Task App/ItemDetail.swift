//
//  ItemDetail.swift
//  Task App
//
//  Created by Logan Miller on 1/2/23.
//

import SwiftUI

struct ItemDetail: View {
    
    var item: ListItem
    @State private var itemTitle: String = ""
    @State private var itemDesc: String = ""
    let coreDM: CoreDataManager
    @Binding var needsRefresh: Bool
    
    
    var body: some View {
        VStack{
            TextField(item.title ?? "", text: $itemTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField(item.desc ?? "", text: $itemDesc)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Update"){
                if !itemTitle.isEmpty{
                    item.title = itemTitle
                    item.desc = itemDesc
                    coreDM.updateItem()
                    needsRefresh.toggle()
                }
            }
        }
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        let item = ListItem()
        let coreDM = CoreDataManager()
        
        ItemDetail(item: item, coreDM: coreDM, needsRefresh: .constant(false))
    }
}
