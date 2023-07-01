import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section (header: Text("Personal Items")) {
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD" ))
                                .foregroundColor(item.amount < 10 ? .blue : item.amount > 100 ? .red : .orange)
                                .fontWeight(item.amount > 100 ? .heavy : .light)
                                .italic(item.amount > 100 ? true : false)
                        }
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(expenses.item.name, expenses.item.amount)
                    .accessibilityHint("\(expenses.item.type)")  
                    .onDelete(perform: removePersonalItems)
                }
                Section (header: Text("Business Items")) {
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD" ))
                                .foregroundColor(item.amount < 10 ? .blue : item.amount > 100 ? .red : .orange)
                                .fontWeight(item.amount > 100 ? .heavy : .light)
                                .italic(item.amount > 100 ? true : false)
                        }
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(expenses.item.name, expenses.item.amount)
                    .accessibilityHint("\(expenses.item.type)")  
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    func removePersonalItems(at offsets: IndexSet) {
        
        // look at each item we are trying to delete
        for offset in offsets {
            
            // look in the personalItems array and get that specific item we are trying to delete. Find it's corresponding match in the expenses.items array.
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.personalItems[offset].id}) {
                
                // delete the item from the expenses.items array at the index you found its match
                expenses.items.remove(at: index)
                
            }
        }
    }
    func removeBusinessItems(at offsets: IndexSet) {
        
        // look at each item we are trying to delete
        for offset in offsets {
            
            // look in the personalItems array and get that specific item we are trying to delete. Find it's corresponding match in the expenses.items array.
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.businessItems[offset].id}) {
                
                // delete the item from the expenses.items array at the index you found its match
                expenses.items.remove(at: index)
                
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}
