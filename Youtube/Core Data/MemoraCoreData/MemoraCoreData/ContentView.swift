//
//  ContentView.swift
//  MemoraCoreData
//
//  Created by Fabian Rodriguez on 12/3/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var showEditScreen = false
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("Memoria App")
                .font(.system(size: 22, weight: .bold))
                .padding()
            
            Spacer()
            
            Image(systemName: "plus.square.on.square")
                .imageScale(.large)
                .padding()
                .onTapGesture {
                    showEditScreen = true
                }
        }
        
        List {
            //TODO: Insert loop notes
            
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 10) {
                    VStack {
                        
                        Text("\(dayOfMonth(from: Date.now))")
                            .font(.title3)
                            .foregroundStyle(.red)
                        
                        Text("\(formatMonthFromDate(Date.now))")
                            .font(.body)
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Text("A completely delightful and fun memory, one that, I never want to forget!")
                        .font(.body)
                    
                    Spacer()
                }
                
                HStack {
                    Text("Tag")
                        .font(.system(size: 12))
                        .foregroundStyle(.black)
                        .padding(5)
                        .background(.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Spacer()
                    
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .onTapGesture {
                            showEditScreen = true
                        }
                }
            }
            .padding(10)
            .background(.teal.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
        }
        .listStyle(PlainListStyle())
        .sheet(isPresented: $showEditScreen) {
            EditNoteView()
                .onDisappear() {
                    //TODO: Perform action
                }
        }
        .onAppear {
            //TODO: Action
        }
    }
    
    private func dayOfMonth(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    private func formatMonthFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
