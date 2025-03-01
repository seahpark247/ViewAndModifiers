//
//  ContentView.swift
//  ViewAndModifiers
//
//  Created by Seah Park on 3/1/25.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
        // 여기서 지워야 밑에서 가져다쓸 때 속성을 덮을 수 있음.
//            .foregroundStyle(.white)
            .background(.blue)
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
            .clipShape(.rect(cornerRadius: 10))
    }
}

// extension of view!
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding()
                .background(.black)
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) {
                        column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var useRedText = false
    let motto1 = Text("motto1")
    let motto2 = Text("motto2")
    
    var body: some View {
        VStack {
            Text("dd").modifier(Title())
            Text("dd2").titleStyle()
            
            CapsuleText(text: "Button")
                .foregroundColor(.yellow)
            
            motto1.foregroundColor(.pink)
            motto2
            
            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Watermark")
            
            GridStack(rows: 4, columns: 4) {
                row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }.font(.subheadline)
        }
        .font(.title)
        
//        Button("Toggle Red Text") {
//            useRedText.toggle()
//        }
//        .foregroundColor(useRedText ? .red : .blue)
    }
}

#Preview {
    ContentView()
}
