//
//  ContentView.swift
//  ViewAndModifiers
//
//  Created by Seah Park on 3/1/25.
//

import SwiftUI

struct Capsule: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
            .padding()
            .background(.yellow)
            .clipShape(.capsule)
    }
}

struct BlueButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .cornerRadius(10)
    }
}

struct Watermark: ViewModifier {
    var text: String = ""
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .background(.black)
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let cols: Int
    // @ViewBuilder let content: (Int, Int) -> Content
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<cols, id: \.self) { col in
                        content(row, col)
                    }
                }
            }
        }
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(BlueButton())
    }
    
    func watermark(_ text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    @State private var toggleRed = false
    
    var body: some View {
        VStack {
            Button("toggle red") {
                toggleRed.toggle()
            }.foregroundColor(toggleRed ? .red : .primary)
            
            Text("modifier").buttonStyle()
            Capsule(text: "capsule")
            Color.pink
                .frame(width: 200, height: 200)
                .watermark("Watermaked")
            
            // GridStack(rows: 3, cols: 3) { row, col in }
            GridStack(rows: 3, cols: 3) { row, col in
                Image(systemName: "\(row * 3 + col).circle")
                Text("\(row),\(col)")
            }.font(.subheadline)
        }
    }
    
}
   
#Preview {
    ContentView()
}
