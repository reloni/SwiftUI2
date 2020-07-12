//
//  TransitionAnimation.swift
//  SwiftUI2
//
//  Created by Anton Efimenko on 12.07.2020.
//

import SwiftUI

struct Switcher: View {
    @Namespace var ns
    @State private var flag = true
    
    var body: some View {
        HStack {
            if flag {
                Rectangle()
                    .fill(Color.green)
                    .matchedGeometryEffect(id: "item1", in: ns)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            Button("Switch") {
                withAnimation(.easeInOut(duration: 2.0)) {
                    flag.toggle()
                }
            }
            
            Spacer()
            
            VStack {
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 50, height: 50)
                
                if !flag {
                    Circle()
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: "item1", in: ns)
                        .border(Color.black)
                        .zIndex(1)
                        .frame(width: 50, height: 50)
                }
                
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 50, height: 50)
            }
        }
        .frame(width: 250)
        .padding()
        .border(Color.gray, width: 3)
    }
}

struct TransitionAnimation_Previews: PreviewProvider {
    static var previews: some View {
        Switcher()
    }
}
