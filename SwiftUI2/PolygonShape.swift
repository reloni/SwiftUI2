//
//  PolygonShape.swift
//  SwiftUI2
//
//  Created by Anton Efimenko on 13.07.2020.
//

import SwiftUI

struct PolygonShapeExample: View {
    @State var sides: Double = 3
    
    var body: some View {
        NavigationView{
            VStack {
                PolygonShape(sides: sides)
                    .stroke(Color.red, lineWidth: 3)
                    .padding(20)
//                    .animation(.easeInOut(duration: 2.0))
//                    .layoutPriority(1)
                
                Text("Sides")
                
                HStack {
                    Button("3") {
                        withAnimation(.easeInOut(duration: 2)) {
                            self.sides = 3
                        }
                    }
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.green).shadow(radius: 2))
                    
                    Button("4") {
                        withAnimation(.easeInOut(duration: 2)) {
                            self.sides = 4
                        }
                    }
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.green).shadow(radius: 2))
                    
                    Button("5") {
                        withAnimation(.easeInOut(duration: 2)) {
                            self.sides = 5
                        }
                    }
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.green).shadow(radius: 2))
                    
                    Button("20") {
                        withAnimation(.easeInOut(duration: 2)) {
                            self.sides = 20
                        }
                    }
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.green).shadow(radius: 2))
                }
                .padding()
            }
//            .navigationBarTitle("Shapes")
        }
    }
}

struct PolygonShapeExample_Previews: PreviewProvider {
    static var previews: some View {
        PolygonShapeExample()
    }
}


struct PolygonShape: Shape {
    var sides: Double
    
    var AnimatableData: Double {
        get { sides }
        set { sides = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        print("!")
        let hypotenuse = Double(min(rect.size.width, rect.size.height)) / 2.0
        
        let center = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        var path = Path()
        
        let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0
                
        for i in 0..<Int(sides) + extra {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180
            
            // Calculate vertex
            let pt = CGPoint(x: center.x + CGFloat(cos(angle) * hypotenuse), y: center.y + CGFloat(sin(angle) * hypotenuse))
            
            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }
        
        path.closeSubpath()
        
        return path
    }
}
