//
//  ContentView.swift
//  ViewAndModifiers
//
//  Created by Seah Park on 3/1/25.
//

import SwiftUI

struct CapsuleButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .padding()
            .background(Color.blue)
            .clipShape(.capsule)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .cornerRadius(10)
    }
}

struct Watermark: ViewModifier {
    var text: String
    
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

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    
    func watermark(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

// 이렇게 뷰를 그릴때는!
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    // var body: some View {}!!!
    var body: some View {
        VStack {
            // 그리드스택 그릴 때 아이디 값 넣어주기-> 그래야 워닝 없어짐!
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var toggleRed = false
    
    var body: some View {
        Button("Toggle red") {
            toggleRed.toggle()
        }.foregroundColor(toggleRed ? .red : .primary)
        
        Text("Title").modifier(Title())
        Text("titleStyle").titleStyle()
        CapsuleButton(text: "capsule").foregroundColor(.yellow)
        
        Color.pink
            .frame(width: 200, height: 200)
            .watermark(with: "Watermark")
        
        GridStack(rows: 4, columns: 4) { row, column in
            Image(systemName: "\(row * 4 + column).circle")
            Text("R\(row) C\(column)")
        }.font(.subheadline)
    }
}

#Preview {
    ContentView()
}
