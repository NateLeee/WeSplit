//
//  ContentView.swift
//  WeSplit
//
//  Created by Nate Lee on 6/25/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var total: Double {
        var total = Double(checkAmount) ?? 0
        total += total * Double(tipPercentages[tipPercentage]) / 100
        return total
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input some info")) {
                    TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
                    TextField("Number of people", text: $numberOfPeople).keyboardType(.numberPad)
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total")) {
                     Text("$ \(total, specifier: "%.2f")")
                }
                Section(header: Text("Total Per Person")) {
                     Text("$ \(totalPerPerson, specifier: "%.2f")")
                    // Text(String(format: "$ %.2f", totalPerPerson))
                }
            }.navigationBarTitle("WeSplit", displayMode: .inline)
        }   
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
