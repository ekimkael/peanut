//
//  OrderView.swift
//  peanut
//
//  Created by Ekim Kael on 03/10/2021.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    ForEach(order.items){item in
                        HStack{
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }.onDelete(perform: deleteItems)
                }
                
                Section{
                    NavigationLink(destination: CheckoutView()){
                        Text("Place your order")
                    }
                }
                .disabled(order.items.isEmpty)
            }
            
            .navigationTitle("Order")
            .listStyle(InsetGroupedListStyle())
            .toolbar{
                EditButton()
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        order.items.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
