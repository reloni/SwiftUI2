//
//  GeometryReader.swift
//  SwiftUI2
//
//  Created by Anton Efimenko on 12.07.2020.
//

import SwiftUI

struct GeometryReaderExample: View {
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("Hello")
                    .padding(.all)
                MyRectangle()
            }
            .frame(width: 150, height: 100)
            .border(Color.black)
            
            HStack {
                Text("Hi")
                    .font(.title)
                    .padding()
                    .background(RoundedCorners(color: .green, tr: 30, bl: 30))
                
                Text("there")
                    .font(.title)
                    .padding()
                    .background(RoundedCorners(color: .green, tl: 30, br: 30))
            }
            .padding()
            .border(Color.red)
        }
    }
}

struct RoundedCorners: View {
    var color: Color = .black
    var tl: CGFloat = 0
    var tr: CGFloat = 0
    var bl: CGFloat = 0
    var br: CGFloat = 0
    
    var body: some View {
        GeometryReader { reader in
            Path { path in
                let w = reader.size.width
                let h = reader.size.height
                
                let tr = min(min(self.tr, h / 2), w / 2)
                let tl = min(min(self.tl, h / 2), w / 2)
                let bl = min(min(self.bl, h / 2), w / 2)
                let br = min(min(self.br, h / 2), w / 2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                                path.addLine(to: CGPoint(x: w - tr, y: 0))
                                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                                path.addLine(to: CGPoint(x: w, y: h - br))
                                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                                path.addLine(to: CGPoint(x: bl, y: h))
                                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                                path.addLine(to: CGPoint(x: 0, y: tl))
                                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(color)
        }
    }
}

struct MyRectangle: View {
    var body: some View {
        GeometryReader { reader in
            Rectangle()
                .path(in: CGRect(x: reader.size.width + 5,
                                 y: 0,
                                 width: reader.size.width / 2,
                                 height: reader.size.height / 2))
                .fill(Color.blue)
        }
    }
}

struct GeometryReaderExample_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderExample()
            .previewDevice("iPhone 11 Pro Max")
    }
}
