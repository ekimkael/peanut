//
//  CheckoutView.swift
//  peanut
//
//  Created by Ekim Kael on 03/10/2021.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    @State private var loyaltyCardExist = false
    @State private var loyaltyCardNumber = ""
    @State private var tipAmount = 0
    @State private var isShow = false
//    simple variable
    let paymentTypes = ["Cash", "Credit Card", "Orange Money"]
    let tipAmounts = [0, 10, 15, 20]
    
    var totalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let total = Double(order.total)
        let tipValue = total/100 * Double(tipAmount)
        
        return formatter.string(from: NSNumber(value: total + tipValue)) ?? "$0"
    }
    
    var body: some View {
        Form{
            Section{
                Picker("How do you want to pay?", selection: $paymentType){
                    ForEach(paymentTypes, id: \.self){
                        Text($0)
                    }
                }
                
                Toggle("Add Peanut loyalty card", isOn: $loyaltyCardExist.animation())
                if loyaltyCardExist {
                    TextField("Enter your Peanut card ID", text: $loyaltyCardNumber)
                }
            }
            
            Section(header: Text("Add a tip")){
                Picker("Percentage", selection: $tipAmount){
                    ForEach(tipAmounts, id: \.self){
                        Text("\($0)%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header:
                        Text("TOTAL: \(totalPrice)")
                        .font(.title)
                        .fontWeight(.bold)
            ){
                Button("Confirm order"){
                    isShow.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $isShow){
            Alert(title: Text("Order confirmed"), message: Text("You order a menu for \(totalPrice)"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Order())
    }
}
